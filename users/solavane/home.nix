{ config, pkgs, ... }: {
  
  programs.git = {
    enable = true;
    settings = {
      user = {
        name  = "solavane";
        email = "solavane@proton.me";
      };
      init.defaultBranch = "main";
    };
  };

  home = {
    username = "solavane";
    homeDirectory = "/home/solavane";
    stateVersion = "25.11";

    packages = with pkgs; [
      jamesdsp
    ];

  };

  nixconf = {
    
    programs = {
      zellij.enable = true;
      zen-browser = {
        enable = true;
        allowedCookieSites = [
          "https://google.com"
          "https://duckduckgo.com"
          "https://github.com"
          "https://spotify.com"
        ];
      };
    }; 
  };
}
