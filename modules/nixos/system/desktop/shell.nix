{ pkgs, config, lib, ... }:

let
  cfg = config.nixconf.desktop.shell;
in
lib.mkIf (config.nixconf.isDesktop && cfg.enable) {
  
  environment.systemPackages = with pkgs; [
    awww
    dunst
    eww
    fuzzel
    pavucontrol
    playerctl
  ];
}
