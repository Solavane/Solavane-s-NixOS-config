{ config, pkgs, ... }: {

  home.packages = with pkgs; [
    spotify-player 
  ];

  services.linux-wallpaperengine.enable = true;

  nixconf = {
    
    programs = {
      blender.enable = true;
      prismlauncher.enable = true;
      godot.enable = true;
      cataclysm-dda.enable = true;
      obs.enable = true;
    };

    flatpaks = {
      sober.enable = true;
    };
    
  };
}
