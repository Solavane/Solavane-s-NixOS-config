{ config, osConfig, lib, pkgs, ... }:

let
  cfg = config.nixconf.programs.element;
in
{
  config = lib.mkIf (osConfig.nixconf.isDesktop && cfg.enable) {

    programs.element-desktop = {
      enable = true;
    };
  };
}
