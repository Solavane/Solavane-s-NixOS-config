{ lib, ... }:

{
  options.nixconf = {
    
    programs = {
      
      blender.enable        = lib.mkEnableOption "Studio level 3d program";
      prismlauncher.enable  = lib.mkEnableOption "minecraft prism launcher";
      cataclysm-dda.enable  = lib.mkEnableOption "Cataclysm: Dark Days Ahead game";
      element.enable        = lib.mkEnableOption "matrix chat client";
      godot.enable          = lib.mkEnableOption "Godot game engine";
      keepass.enable        = lib.mkEnableOption "local password manager";
      obs.enable            = lib.mkEnableOption "OBS Studio screen recording and streaming";
      zellij.enable         = lib.mkEnableOption "Terminal multiplexer";

      zen-browser = {
        enable              = lib.mkEnableOption "minimal browser";
        allowedCookieSites  = lib.mkOption {
          type              = lib.types.listOf lib.types.str;
          default = [
            "https://google.com"
            "https://duckduckgo.com"
            "https://github.com"    
          ];
          description = "list of allowed websites to store cookies when Zen closes";
        };
        uBlockBlocklist     = lib.mkOption {
          type              = lib.types.listOf lib.types.str;
          default = [
            "www.youtube.com##ytd-rich-section-renderer.ytd-rich-grid-renderer.style-scope" # Disables yucky shorts on homepage
          ];
          description = "Custom filters uBlock origin will use to remove elements";
        };
      };

    };

    services = {
      syncthing.enable      = lib.mkEnableOption "automatic filesyncing between devices";
    };

    flatpaks = {
      sober.enable          = lib.mkEnableOption "Sober Roblox client";
    };
  };
}
