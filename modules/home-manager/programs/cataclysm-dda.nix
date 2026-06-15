{ config, osConfig, lib, pkgs, ... }:

let
  cfg = config.nixconf.programs.cataclysm-dda;
in
{
  config = lib.mkIf (osConfig.nixconf.isDesktop && cfg.enable) {
    home.packages = with pkgs; [
      cataclysm-dda
    ];
  };
}


#    home.packages = let
#      cdda-experimental-bin = pkgs.stdenv.mkDerivation rec {
#        pname = "cataclysm-dda-experimental-bin";
#        version = "2026-06-15-1602"; 
#    
#        src = pkgs.fetchurl {
#          url = "https://github.com/CleverRaven/Cataclysm-DDA/releases/download/cdda-experimental-2026-06-15-1602/cdda-linux-with-graphics-and-sounds-x64-2026-06-15-1602.tar.gz";
#          hash = "sha256-ih5hUo54MsM0JuHL5JWJo+rqQ4D7GNOSkwvqXbJ1zRU="; 
#        };
#    
#        nativeBuildInputs = [
#          pkgs.autoPatchelfHook
#          pkgs.makeWrapper
#        ];
#    
#        buildInputs = [
#          pkgs.SDL2
#          pkgs.SDL2_image
#          pkgs.SDL2_ttf
#          pkgs.SDL2_mixer
#          pkgs.libsndfile
#          pkgs.stdenv.cc.cc.lib
#          pkgs.vulkan-loader
#          pkgs.mesa
#          pkgs.libGL
#          pkgs.libglvnd
#        ];
#
#        autoPatchelfIgnoreMissingDeps = [ "libsteam_api.so" ];
#    
#        dontBuild = true;
#    
#        installPhase = ''
#          runHook preInstall
#
#          mkdir -p $out/bin
#          mkdir -p $out/share/cataclysm-dda
#
#          cp -r * $out/share/cataclysm-dda/
#
#          mv $out/share/cataclysm-dda/cataclysm-tiles $out/bin/cataclysm-tiles
#
#          wrapProgram $out/bin/cataclysm-tiles \
#            --run "cd $out/share/cataclysm-dda"
#
#          runHook postInstall 
#        '';
#      };
#    in [
#      # ... your other system packages ...
#      cdda-experimental-bin
#    ];
#  };
#}
