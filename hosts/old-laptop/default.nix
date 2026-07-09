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
        ../../users/solavane/home-old-laptop.nix
      ];
    };

  };

  networking.hostName = "old-laptop";

  nixconf = { #Module imports
    
    desktop = {

      mango = {
        enable = true;
        monitors = [
          "make:AU Optronics, width:1366, height:768, refresh:60, x:0, y:0"
        ];
      };
    };

    sddm.enable = true;


    programs = {

      foot.enable = true;
      pcmanfm.enable = true;
      librewolf.enable = true;
      elinks.enable = true;
      
    };
  };
}
