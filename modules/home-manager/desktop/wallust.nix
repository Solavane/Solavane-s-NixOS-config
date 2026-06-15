{ config, lib, ... }:

let
  enabled = config.nixconf.desktop.wallust.enable;
in
{
  config = lib.mkIf enabled {
    services.wallust = {
      enable = true;
      settings = {
        
      };
    };
  };
}
    
