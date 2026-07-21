{ config, lib, pkgs, ... }:

let
  cfg = config.nixconf.programs.pcmanfm;
in
{
  config = lib.mkIf (config.nixconf.isDesktop && cfg.enable) {

    environment.systemPackages = with pkgs; [
      pcmanfm
      xarchiver
    ];

    services = {
      udisks2.enable = true;
      devmon.enable = true;
      gvfs.enable = true;
    };
  };
}
