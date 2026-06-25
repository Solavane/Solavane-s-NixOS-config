{ config, osConfig, lib, pkgs, inputs, ... }:

let
  cfg = config.nixconf.programs.blender;
in
{
  config = lib.mkIf (osConfig.nixconf.isDesktop && cfg.enable) {

    home.packages = with pkgs; [
      blender
    ];
  };
}
