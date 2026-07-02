{ lib, osConfig, ... }:

let
  enabled = osConfig.nixconf.desktop.shell.enable;

in {
  config = lib.mkIf enabled {
    
    programs.eww = {
      enable = true;
      systemd.enable = true;
    };
  };
}

