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
        ../../users/solavane/home-dell-laptop.nix
      ];
    };

  };

  networking.hostName = "dell-laptop";

  nixconf = { #Module imports
    
    system = {
      sddm.enable = true;

      desktop = {
        attract-mode.enable = true;

        mango = {
          enable = true;
          monitors = [
            "#make:AU Optronics, width:1366, height:768, refresh:60, x:0, y:0"
          ];
        };
      };
    };


    programs = {

      foot.enable = true;
      pcmanfm.enable = true;
      localsend.enable = true;
      elinks.enable = true;
      vesktop.enable = true;
      
    };
  };
}
