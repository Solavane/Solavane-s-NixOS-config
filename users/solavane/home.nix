{ config, pkgs, ... }: {
  
  # Secrets manager for user secrets
  sops.defaultSopsFile = ./secrets.yaml;
  sops.age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

  home = {
    username = "solavane";
    homeDirectory = "/home/solavane";
    stateVersion = "25.11";

  };

  nixconf = {
    
    programs = {
      keepass.enable = true;
      zellij.enable = true;
      zen-browser = {
        enable = true;
        allowedCookieSites = [
          "https://google.com"
          "https://duckduckgo.com"
          "https://github.com"
          "https://spotify.com"
          "https://oraclecloud.com"
        ];
      };
    }; 

    services = {
      syncthing = {
        enable = true;
      };
    };
  };
  
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

  programs.ssh.enable = true;

  ###############################################################
  # Move this to shared home once I have the energy to fix that #
  ###############################################################

  xdg.autostart.enable = true;
}
