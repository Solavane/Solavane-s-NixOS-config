{ config, lib, osConfig, ... }:

let
  enabled = config.nixconf.desktop.awww.enable;
in
{
  config = lib.mkIf enabled {
    services.awww = {
      enable = true;
      extraArgs = [
        
      ];
    };
  };
}
    
