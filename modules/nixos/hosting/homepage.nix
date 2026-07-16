{ config, lib, ... }:

let
  cfg = config.nixconf.hosting.homepage;
  domain = config.nixconf.hosting.domain;
in
{
  config = lib.mkIf cfg.enable {
    
    services.homepage-dashboard = {
      enable = true;
      
      listenPort = 8082;
      allowedHosts = "${config.nixconf.hosting.domain},localhost:8082";

      widgets = [
        { resources = { cpu = true; memory = true; disk = "/"; }; }
        { datetime = { text_size = "xl"; format.dateStyle = "long"; }; }
      ];
      services = [
        {
          "hosting" = [
            {
              "Matrix" = {
                icon = "matrix.png";
                description = "Matrix chat service";
                href = "https://${domain}";
                siteMonitor = "https://${domain}";
              };
            }
          ];
        }
      ];
    };

    services.nginx.virtualHosts."${domain}".locations."/homepage/" = {
      proxyPass = "http://127.0.0.1:8082/";
    };
  };
}
