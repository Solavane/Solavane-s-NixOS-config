{ config, lib, ... }:

let
  cfg = config.nixconf.hosting.matrix;
  domain = config.nixconf.hosting.domain;
in
{
  imports = [
    ./livekit.nix
    ./turn.nix
  ];

  config = lib.mkIf cfg.enable {
    sops.secrets."registration_token" = { 
      owner = "tuwunel";
      group = "tuwunel";
      mode = "0440";
    };
    sops.secrets."turn_secret" = {
      owner = "turnserver";
      group = "tuwunel";
      mode = "0440";
    };
    users.users.tuwunel.extraGroups = [ "turnserver" ];

    services.matrix-tuwunel = {
      enable = true;
      settings.global = {
        server_name = domain;
        address = [ "127.0.0.1" ];
        port = [ 6169 ];
        allow_registration = false;
        registration_token_file = config.sops.secrets."registration_token".path;

        turn_uris = [
          "turn:${domain}:3478?transport=udp"
          "turn:${domain}:3478?transport=tcp"
        ];
        
        turn_secret_file = config.sops.secrets."turn_secret".path;
      };
    };

    services.nginx.virtualHosts."${domain}" = {
      enableACME = true;
      forceSSL = true;

      locations = {
        "/_matrix/" = {
          proxyPass = "http://127.0.0.1:6169";
        };

        "= /.well-known/matrix/server" = {
          extraConfig = ''
            add_header Content-Type application/json;
            add_header Access-Control-Allow-Origin *;
            return 200 '{"m.server": "${domain}:443"}';
          '';
        };

        "= /.well-known/matrix/client" = {
          extraConfig = ''
            add_header Content-Type application/json;
            add_header Access-Control-Allow-Origin *;
            return 200 '{"m.homeserver": {"base_url": "https://${domain}"}, "m.identity_server": {"base_url": "https://vector.im"}, "org.matrix.msc3575.proxy": {"url": "https://${domain}"}, "org.matrix.msc4143.rtc_foci": [{"type": "livekit", "livekit_service_url": "https://${domain}/livekit/jwt"}]}';
          '';
        };
        "^~ /livekit/jwt/" = {
          priority = 400;
          proxyPass = "http://[::1]:${toString config.services.lk-jwt-service.port}/";
        };

        "^~ /livekit/sfu/" = {
          priority = 400;
          proxyPass = "http://[::1]:${toString config.services.livekit.settings.port}/";
          proxyWebsockets = true;
          extraConfig = ''
            proxy_send_timeout 120;
            proxy_read_timeout 120;
            proxy_buffering off;
            proxy_set_header Accept-Encoding gzip;
          '';
        };
      };
    };
  };
}
