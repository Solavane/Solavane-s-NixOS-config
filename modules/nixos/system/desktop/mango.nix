{ config, lib, pkgs, inputs, ... }:

let
  cfg = config.nixconf.desktop.mango;
  
  portalPkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/e6f23dc08d3624daab7094b701aa3954923c6bbb.tar.gz";
    sha256 = "0m0xmk8sjb5gv2pq7s8w7qxf7qggqsd3rxzv3xrqkhfimy2x7bnx";
  }) { 
    system = pkgs.stdenv.hostPlatform.system; 
  };

  customWlroots = assert lib.assertMsg (lib.versionOlder pkgs.wlroots_0_19.version "0.20.0")
    "wlroots updated; remove wlroots-unstable override";
    pkgs.wlroots_0_19.overrideAttrs (old: {
      version = "0.20";
      src = pkgs.fetchFromGitLab {
        domain = "gitlab.freedesktop.org";
        owner = "wlroots";
        repo = "wlroots";
        rev = "bba38a0d82f65234c320f4a31b9e3e8d1d42366b";
        hash = "sha256-EWE3arP8uBbIF+KIn1/I0kTRoRvwqNWEVXpVNcDxCmU=";
      };
    });

  customMango = (pkgs.mango.override {
    wlroots_0_19 = customWlroots;
  }).overrideAttrs (old: {
    src = pkgs.fetchFromGitHub {
      owner = "mangowm";
      repo = "mango";
      rev = "8e8710ea7618cc4a5ff22be463448c253a6265c6";
      hash = "sha256-QpVvSQM3j5YAUjMhB3vZtyxfa2wuDy0geshHpYS8iuA=";
    };
  });
in
{
  imports = [
    inputs.mango.nixosModules.mango
  ];

  config = lib.mkIf (config.nixconf.isDesktop && cfg.enable) {
    nixpkgs.overlays = [
      (final: prev: {
        xdg-desktop-portal-wlr = portalPkgs.xdg-desktop-portal-wlr;
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
      customMango
    ];

    security.polkit.enable = true;
  };
}

#{ config, lib, pkgs, inputs, ... }:
#
#let
#  cfg = config.nixconf.desktop.mango;
#  portalPkgs = import (builtins.fetchTarball { #URL for portal 0.7.1
#      url = "https://github.com/NixOS/nixpkgs/archive/e6f23dc08d3624daab7094b701aa3954923c6bbb.tar.gz";
#      sha256 = "0m0xmk8sjb5gv2pq7s8w7qxf7qggqsd3rxzv3xrqkhfimy2x7bnx";
#  }) { inherit (config.nixpkgs) system; };
#in
#{
#  imports = [
#    inputs.mango.nixosModules.mango
#  ];
#
#
#  config = lib.mkIf (config.nixconf.isDesktop && cfg.enable) {
#    nixpkgs.overlays = [
#      (final: prev: {
#        xdg-desktop-portal-wlr = portalPkgs.xdg-desktop-portal-wlr;
#      })
#    ];
#    programs.mango.enable = true;
#    
#    xdg.portal = {
#      enable = true;
#      extraPortals = [ ];  
#      wlr.enable = true;
#    };
#    
#    environment.systemPackages = with pkgs; [
#      grim
#      slurp
#      wl-clipboard-rs
#      satty
#      wayfreeze
#      jq
#      (pkgs.mangowc.override {
#        wlroots_0_19 = (
#          assert lib.assertMsg (lib.versionOlder pkgs.wlroots_0_19.version "0.20.0")
#            "wlroots updated; remove wlroots-unstable override";
#          pkgs.wlroots_0_19.overrideAttrs (old: {
#            version = "0.20";
#            src = pkgs.fetchFromGitLab {
#              domain = "gitlab.freedesktop.org";
#              owner = "wlroots";
#              repo = "wlroots";
#              rev = "bba38a0d82f65234c320f4a31b9e3e8d1d42366b";
#              hash = "sha256-EWE3arP8uBbIF+KIn1/I0kTRoRvwqNWEVXpVNcDxCmU=";
#            };
#          })
#        );
#      }).overrideAttrs
#        {
#          src = pkgs.fetchFromGitHub {
#            owner = "mangowm";
#            repo = "mango";
#            rev = "8e8710ea7618cc4a5ff22be463448c253a6265c6";
#            hash = "sha256-QpVvSQM3j5YAUjMhB3vZtyxfa2wuDy0geshHpYS8iuA=";
#          };
#        };
#    ];
#
#    security.polkit.enable = true;
#  };
#}
