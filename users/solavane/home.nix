{ config, ... }: {
  
  home = {
    username = "solavane";
    homeDirectory = "/home/solavane";
    stateVersion = "25.11";
  };

  nixconf = {
    
    programs = {
      prismlauncher.enable = true;
      cataclysm-dda.enable = true;
      obs.enable = true;
    };
  
  };
}
