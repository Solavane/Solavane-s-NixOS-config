{ lib, ... }:

{
  options.nixconf = {
    desktop = {
      awww.enable = lib.mkEnableOption "Animated wallpaper thing";
    };

    programs = {
      prismlauncher.enable = lib.mkEnableOption "minecraft prism launcher";
      obs.enable           = lib.mkEnableOption "OBS Studio screen recording and streaming";
    };
  };
}
