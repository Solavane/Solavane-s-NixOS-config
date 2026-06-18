{ config, pkgs, ... }: {

  home.packages = with pkgs; [
    spotify-player 
  ];

  nixconf = {
    
    programs = {
      prismlauncher.enable = true;
      cataclysm-dda.enable = true;
      obs.enable = true;
    };

    flatpaks = {
      sober.enable = true;
    };
    
  };
}
