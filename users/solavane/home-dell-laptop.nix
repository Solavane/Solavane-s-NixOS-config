{ config, pkgs, ... }: {

  nixconf = {
    
    programs = {
      prismlauncher.enable = true;
    };
    
    flatpaks = {
      sober.enable = true;
    };
  };
}
