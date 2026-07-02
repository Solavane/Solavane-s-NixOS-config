{ pkgs, config, lib, ... }:

let
  cfg = config.nixconf.desktop.shell;
in
lib.mkIf (config.nixconf.isDesktop && cfg.enable) {
  
  environment.systemPackages = with pkgs; [
    awww
    cliphist
    dunst
    eww
    fuzzel
    matugen
    pavucontrol
    playerctl
  ];

  services.dunst = {
    enable = true;
    enableX11 = false;
  };
}
