{ config, osConfig, lib, pkgs, ... }:

let
  cfg = config.nixconf.programs.godot;
in
{
  config = lib.mkIf (osConfig.nixconf.isDesktop && cfg.enable) {

    home.packages = with pkgs; [
      godot
    ];
  };
}
