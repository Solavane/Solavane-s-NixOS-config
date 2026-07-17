{ config, lib, pkgs, inputs, ... }:

let
  cfg = config.nixconf.system.desktop.mango;
  pkgs = import (builtins.fetchTarball { #URL for portal 0.7.1
      url = "https://github.com/NixOS/nixpkgs/archive/e6f23dc08d3624daab7094b701aa3954923c6bbb.tar.gz";
      sha256 = "0m0xmk8sjb5gv2pq7s8w7qxf7qggqsd3rxzv3xrqkhfimy2x7bnx";
  }) { inherit (config.nixpkgs) system; };
in
{
  imports = [
    inputs.mango.nixosModules.mango
  ];


  config = lib.mkIf (config.nixconf.isDesktop && cfg.enable) {
    nixpkgs.overlays = [
      (final: prev: {
        xdg-desktop-portal-wlr = pkgs.xdg-desktop-portal-wlr;
      })
    ];
    programs.mango.enable = true;
    
    xdg.portal = {
      enable = true;
      extraPortals = [ ];  
      wlr.enable = true;
    };
    
    environment.systemPackages = with pkgs; [
      grim
      slurp
      wl-clipboard-rs
      satty
      wayfreeze
      jq
    ];
    
    security.polkit.enable = true;
  };
}
