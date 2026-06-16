{ config, pkgs, ... }: {

  nixconf = {
    
    programs = {
      prismlauncher.enable = true;
      cataclysm-dda.enable = true;
      obs.enable = true;
    };
  
  };
}
