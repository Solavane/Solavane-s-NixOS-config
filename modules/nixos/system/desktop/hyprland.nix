{ config, lib, ... }:

let
  cfg = config.nixconf.desktop.hyprland;
in
lib.mkIf (config.nixconf.isDesktop && cfg.enable) {

  programs.hyprland = {
    enable       = true;
    xwayland.enable = true;
  };

  # XDG portal — required for screen sharing, file pickers
  xdg.portal = {
    enable = true;
    extraPortals = [ ];   # hyprland-portals added by programs.hyprland
  };

  security.polkit.enable = true;
}
