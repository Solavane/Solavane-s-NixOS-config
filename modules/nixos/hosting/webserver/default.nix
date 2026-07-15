{ config, lib, ... }:

let
  cfg = config.nixconf.hosting.webserver;
in
{
  config = lib.mkIf cfg.enable {
    services.nginx = {
      enable = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;
    };

    security.acme = {
      acceptTerms = true;
      defaults.email = "solavane@proton.me";
    };

    networking.firewall.allowedTCPPorts = [ 80 443 ];
  };
}
