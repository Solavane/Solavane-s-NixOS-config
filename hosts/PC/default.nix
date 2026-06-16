{ config, lib, pkgs, ... }: {
  imports = [
    ../shared/default.nix
    ../../users/solavane/default.nix
    ./hardware-configuration.nix
    ./system-configuration.nix
  ];

  home-manager.users = { # :Imports for user HMs
    
    solavane = { ... }: {
      imports = [
        ../../users/solavane/home.nix
        ../../users/solavane/home-PC.nix
      ];
    };

  };

  networking.hostName = "PC";

  nixconf = { #Module imports
    isDesktop = true;
    nvidia.enable = true;
    
    desktop = {

      mango = {
        enable = true;
        monitors = [
          "name:DP-1,     width:2560, height:1440, refresh:240, x:2560, y:0"
          "name:HDMI-A-1, width:2560, height:1440, refresh:120, x:0,    y:0"
        ];
      };

      dms.enable = true;
      #wallpaperTheming.enable = true;

    };


    programs = {

      foot.enable = true;
      pcmanfm.enable = true;
      librewolf.enable = true;
      keepass.enable = true;
      vesktop.enable = true;
      steam.enable = true;
      faugus.enable = true;

    };
  };
}
