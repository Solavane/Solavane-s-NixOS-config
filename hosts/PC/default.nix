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
    nvidia.enable = true;
    sddm.enable = true;
    
    desktop = {

      mango = {
        enable = true;
        monitors = [
          "name:DP-1,     width:2560, height:1440, refresh:240, x:2560, y:0, vrr:0, rr:0 :hdr:1"
          "name:HDMI-A-1, width:2560, height:1440, refresh:120, x:0,    y:0"
        ];
      };

    };
    programs = {

      foot.enable = true;
      pcmanfm.enable = true;
      localsend.enable = true;
      vesktop.enable = true;
      steam.enable = true;
      faugus.enable = true;

    };
    services = {
      
      ollama.enable = true;

    };
  };
}
