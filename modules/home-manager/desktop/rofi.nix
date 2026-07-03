{ lib, osConfig, ... }: 
let
  enabled = osConfig.nixconf.desktop.shell.enable;
in
{
  config = lib.mkIf enabled {

    programs.rofi = {
      enable = true;
      terminal = "\${pkgs.foot}/bin/foot";
      modes = [
        "drun"
        "window"
        "filebrowser"
      ];
      extraConfig = {
        show-icons = true;
        "drun" = {
          display-name = "Application";
        };

      };
    };
  };
}
