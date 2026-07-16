{ config, lib, pkgs, ... }:

let
  cfg = config.nixconf.hosting.matrix;
  domain = config.nixconf.hosting.domain;
  keyFile = "/run/livekit.key";
in
{
  config = lib.mkIf cfg.enable {
    services.livekit = {
      enable = true;
      openFirewall = true;
      settings.room.auto_create = false;
      inherit keyFile;
    };

    services.lk-jwt-service = {
      enable = true;
      livekitUrl = "wss://${domain}/livekit/sfu";
      inherit keyFile;
    };

    # generates the shared key on first boot; both services wait on it
    systemd.services.livekit-key = {
      before = [ "lk-jwt-service.service" "livekit.service" ];
      wantedBy = [ "multi-user.target" ];
      path = with pkgs; [ livekit coreutils gawk ];
      script = ''
        echo "lk-jwt-service: $(livekit-server generate-keys | tail -1 | awk '{print $3}')" > "${keyFile}"
      '';
      serviceConfig.Type = "oneshot";
      unitConfig.ConditionPathExists = "!${keyFile}";
    };

    # restrict auto room-creation homeserver
    systemd.services.lk-jwt-service.environment.LIVEKIT_FULL_ACCESS_HOMESERVERS = domain;
  };
}
