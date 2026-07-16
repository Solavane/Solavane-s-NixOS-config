{ config, lib, ... }:

let
  cfg = config.nixconf.hosting.matrix;
  domain = config.nixconf.hosting.domain;
in
{
  config = lib.mkIf cfg.enable {

    services.coturn = {
      enable = true;
      use-auth-secret = true;
      static-auth-secret-file = config.sops.secrets."turn_secret".path;
      realm = domain;

      # Listening ports
      listening-port = 3478;
      tls-listening-port = 5349;

      # Relay ports range (used to stream media)
      min-port = 49152;
      max-port = 65535;
    };

    networking.firewall = {
      allowedTCPPorts = [ 3478 5349 ];
      allowedUDPPorts = [ 3478 5349 ];
      allowedUDPPortRanges = [
        { from = 49152; to = 65535; }
      ];
    };
  };
}
