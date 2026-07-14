{ config, lib, pkgs, modulesPath,... }: {
  imports = [
    ../shared/default.nix
    ../../users/solavane/default.nix
    ./system-configuration.nix
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  users.users.root.openssh.authorizedKeys.keyFiles = [
    ./oracle_vps.pub
  ];

  home-manager.users = { # :Imports for user HMs
    
    solavane = { ... }: {
      imports = [
        ../../users/solavane/home.nix
        ../../users/solavane/home-oracle-vps.nix
      ];
    };

  };

  networking.hostName = "oracle-vps";

  nixconf = { #Module imports    
    services = {
      
    };
  };
}
