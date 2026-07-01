{ config, pkgs, ... }: {

  nixconf = {
    
    programs = {

    };
    
    flatpaks = {
      sober.enable = true;
    };
  };
}
