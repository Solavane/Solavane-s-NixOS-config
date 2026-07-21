{ config, lib, ... }:

let
  cfg = config.nixconf.hosting.ddns;
in
{
  config = lib.mkIf cfg.enable {
    sops.secrets."domainAPI" = { };
    services.cloudflare-dyndns = {
      enable = true;
      domains = [ 
        config.nixconf.hosting.domain
        "fjomp.${config.nixconf.hosting.domain}"
      ];
      apiTokenFile = config.sops.secrets."domainAPI".path;
    };
  };
}
