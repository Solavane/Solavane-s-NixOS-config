{ pkgs, config, lib, ... }:

let
  cfg = config.nixconf.system.desktop.shell;
in
lib.mkIf (config.nixconf.isDesktop && cfg.enable) {
  
  environment.systemPackages = with pkgs; [
    awww
    cliphist
    dunst
    eww
    matugen
    pavucontrol
    playerctl
    rofi
  ];

  services.dunst = {
    enable = true;
    enableX11 = false;
  };
}
