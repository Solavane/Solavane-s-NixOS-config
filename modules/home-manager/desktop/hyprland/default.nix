{ config, lib, osConfig, ... }:

let
  enabled = osConfig.nixconf.isDesktop && osConfig.nixconf.desktop.hyprland.enable;
in
lib.mkIf enabled {

  wayland.windowManager.hyprland = {
    enable   = true;
    extraConfig = builtins.readFile ./hyprland.conf;
  };
}
