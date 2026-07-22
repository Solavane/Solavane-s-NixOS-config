# Reference: https://github.com/Misterio77/Foundry/blob/main/hosts/taygeta/services/minecraft/servers/gtnh/default.nix

{lib, pkgs, config, ...}: let
  cfg = config.nixconf.hosting.minecraft-servers.gtnh;
in {
  config = lib.mkIf cfg.enable {
    
    services.minecraft-servers.servers.gtnh = rec {
      enable = true;
      openFirewall = true;

      enableReload = true;
      package = pkgs.callPackage ./gtnh.nix { };
      jvmOpts = "-Xms3G -Xmx6G -Dfml.readTimeout=180";
      whitelist = { 
        Solavane = "12c603b6-d15c-4ae9-8357-6a1dc630d5d1";
      };
      operators = {
        Solavane = "12c603b6-d15c-4ae9-8357-6a1dc630d5d1";
      };
      serverProperties = {
        level-type = "rwg";
        difficulty = 3;
        spawn-protection = 1;
        server-port = 43030;
        online-mode = true;
        white-list = true;
        motd = ":3";
        max-tick-time = 60000; # 1 minute
      };
      files = {
        config = "${package}/lib/config";
        serverutilities = "${package}/lib/serverutilities";
        #"serverutilities/serverutilities.cfg" = ./configs/serverutilities.cfg;
      };
      symlinks = {
        "mods/distanthorizons-alpha20.jar" = pkgs.fetchurl rec {
          pname = "distanthorizons";
          version = "alpha20";
          url = "https://github.com/DarkShadow44/DistantHorizonsStandalone/releases/download/alpha20/distanthorizons-alpha20.jar";
          hash = "sha256-FkhFzdK0QMGfp6g8NIwxL0SWsxrWlg4pFpi6ry1x75U=";
        };
      };
    };
  };
}
