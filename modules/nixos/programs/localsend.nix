{ config, lib, pkgs, ... }:

let
  cfg = config.nixconf.programs.localsend;
in
{
  config = lib.mkIf (config.nixconf.isDesktop && cfg.enable) {
    
    programs.localsend = {
      enable = true;
      openFirewall = true;
    };
  };
}
