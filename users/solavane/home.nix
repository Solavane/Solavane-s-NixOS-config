{ config, ... }: {
  
  home = {
    username = "solavane";
    homeDirectory = "/home/solavane";
    stateVersion = "25.11";
  };

  home.packages = [
    jamesdsp
  ];

  nixconf = {
    
    programs = {
      prismlauncher.enable = true;
      cataclysm-dda.enable = true;
      obs.enable = true;
    };
  
  };
}
