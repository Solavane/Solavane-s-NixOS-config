{ config, lib, ... }:

let
  cfg = config.nixconf.hosting.minecraft-servers;
in
{
  imports = [
    ./fjomp/default.nix
    ./gtnh/default.nix
  ];

  config = lib.mkIf cfg.enable {
    services.minecraft-servers = {
      enable = true;
      eula = true;
      openFirewall = true;
    };
  };
}
