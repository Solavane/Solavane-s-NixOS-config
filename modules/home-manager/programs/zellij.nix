{ config, osConfig, lib, pkgs, ... }:

let
  cfg = config.nixconf.programs.zellij;
in
{
  config = lib.mkIf (osConfig.nixconf.isDesktop && cfg.enable) {

    programs.zellij = {
      enable = true;
    };
  };
}
