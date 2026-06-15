{ lib, ... }:

{
  options.nixconf = {
    desktop = {
      awww.enable = lib.mkEnableOption "Animated wallpaper thing";
    };

    programs = {
      prismlauncher.enable = lib.mkEnableOption "minecraft prism launcher";
      cataclysm-dda.enable = lib.mkEnableOption "Cataclysm: Dark Days Ahead game";
      obs.enable           = lib.mkEnableOption "OBS Studio screen recording and streaming";
    };
  };
}
