{ osConfig, lib, pkgs, ... }: {

  config = lib.mkIf osConfig.nixconf.desktop.wallpaperTheming.enable {
    
    services.awww.enable = true;

    programs.wallust = {
      enable = true;
      settings = {
        backend = "fast-resize";
        color_space = "lch";
        threshold = 20;
      };
    };

    home.packages = [
      (pkgs.writeShellScriptBin "set-wallpaper" ''
        awww img --transition-duration 0.5 -a "$1"
        wallust run "$1"
      '')
    ];
  };
}

