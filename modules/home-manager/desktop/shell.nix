{ pkgs, config, lib, osConfig, ... }:

let
  enabled = osConfig.nixconf.system.desktop.shell.enable;
in
{
  config = lib.mkIf enabled {
    
    services.awww = {
      enable = true;
      extraArgs = [
        
      ];
    };
    
    #services.cliphist = {
    #  enable = true;

    #  systemdTargets = ["graphical-session.target"];
    #};

  };
}
