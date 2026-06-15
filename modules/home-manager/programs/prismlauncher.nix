{ config, osConfig, lib, pkgs, ... }:

let
  cfg = config.nixconf.programs.prismlauncher;
in
{
  config = lib.mkIf (osConfig.nixconf.isDesktop && cfg.enable) {

    home.packages = with pkgs; [
      (prismlauncher.override {
        additionalPrograms = [ ffmpeg ];

        jdks = [
          pkgs.jdk25
        ];
      })
    ];
  };
}
