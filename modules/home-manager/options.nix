{ lib, ... }:

{
  options.nixconf = {
    desktop = {
      awww.enable = lib.mkEnableOption "Animated wallpaper thing";
    };

    programs = {
      blender.enable        = lib.mkEnableOption "Studio level 3d program";
      prismlauncher.enable  = lib.mkEnableOption "minecraft prism launcher";
      cataclysm-dda.enable  = lib.mkEnableOption "Cataclysm: Dark Days Ahead game";
      godot.enable          = lib.mkEnableOption "Godot game engine";
      obs.enable            = lib.mkEnableOption "OBS Studio screen recording and streaming";
    };

    flatpaks = {
      sober.enable          = lib.mkEnableOption "Sober Roblox client";
    };
  };
}
