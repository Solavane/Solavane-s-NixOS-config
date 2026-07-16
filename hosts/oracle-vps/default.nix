{ config, lib, pkgs, modulesPath,... }: {

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/var/lib/sops-nix/key.txt";
  };

  imports = [
    ../shared/default.nix
    ../../users/solavane/default.nix
    ./system-configuration.nix
    ./disko.nix
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  users = {
    mutableUsers = false;
    users.solavane = {
      openssh.authorizedKeys.keyFiles = [
        ./oracle_vps.pub
      ];
    };
    users.root = {
      openssh.authorizedKeys.keyFiles = [
        ./oracle_vps.pub
      ];
    };
  };

  systemd.targets.multi-user.enable = true;

  home-manager.users = { # :Imports for user HMs
    
    solavane = { ... }: {
      imports = [
        ../../users/solavane/home.nix
        ../../users/solavane/home-oracle-vps.nix
      ];
    };

  };

  networking.hostName = "oracle-vps";
  networking.networkmanager.enable = true;

  nixconf = { #Module imports    
    hosting = {
      domain = "solavane.fyi";
      webserver.enable = true;
      ddns.enable = true;
      matrix.enable = true;
      homepage.enable = true;
      
      minecraft-servers = {
        enable = true;
        fjomp.enable = true;
      };
    };

    services = {
      
    };
  };
}
