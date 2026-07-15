{ config, lib, ... }:

let
  cfg = config.nixconf.hosting.matrix;
  domain = config.nixconf.hosting.domain;
in
{
  config = lib.mkIf cfg.enable {
    sops.secrets."registration_token" = { 
      owner = "tuwunel";
      group = "tuwunel";
      mode = "0440";
    };

    services.matrix-tuwunel = {
      enable = true;
      settings.global = {
        server_name = domain;
        address = [ "127.0.0.1" ];
        port = [ 6169 ];
        allow_registration = true; # Set to false once registered!
        registration_token_file = config.sops.secrets."registration_token".path;
      };
    };

    services.nginx.virtualHosts."${domain}" = {
      enableACME = true;
      forceSSL = true;

      locations."/_matrix/" = {
        proxyPass = "http://127.0.0.1:6169";
      };

      locations."= /.well-known/matrix/server" = {
        extraConfig = ''
          add_header Content-Type application/json;
          add_header Access-Control-Allow-Origin *;
          return 200 '{"m.server": "${domain}:443"}';
        '';
      };

      locations."= /.well-known/matrix/client" = {
        extraConfig = ''
          add_header Content-Type application/json;
          add_header Access-Control-Allow-Origin *;
          return 200 '{"m.homeserver": {"base_url": "https://${domain}"}}';
        '';
      };
    };
  };
}
