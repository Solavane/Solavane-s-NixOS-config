{ lib, osConfig, ... }:

let
  enabled = osConfig.nixconf.system.desktop.shell.enable;

in {
  config = lib.mkIf enabled {
    xdg.configFile = {
      "matugen/config.toml".source = ./config.toml;
      "matugen/templates" = {
        source = ./templates;
        recursive = true;
      };
    };
  };
}
