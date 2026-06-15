{ config, lib, pkgs, ... }:

let
  cfg = config.nixconf.desktop.dms;
in
lib.mkIf (config.nixconf.isDesktop && cfg.enable) {
  programs.dms-shell = {
    enable = true;
    systemd.enable = true;
  };
}
