{ config, pkgs, ... }: {

  nixconf = {
    
    programs = {
      cataclysm-dda.enable = true;
    };

  };
}
