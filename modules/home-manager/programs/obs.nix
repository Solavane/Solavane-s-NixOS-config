{ config, osConfig, lib, pkgs, ... }:

let
  cfg = config.nixconf.programs.obs;
in
{
  config = lib.mkIf (osConfig.nixconf.isDesktop && cfg.enable) {

    home.packages = with pkgs; [
      obs-studio
    ];
  };
}
