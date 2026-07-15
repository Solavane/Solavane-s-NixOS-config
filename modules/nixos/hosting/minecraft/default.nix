{ config, osConfig, lib, pkgs, ... }:

let
  cfg = config.nixconf.hosting.minecraft-servers;
in
{
  imports = [
    ./fjomp/default.nix
  ];

  config = lib.mkIf cfg.enable {
    services.minecraft-servers = {
      enable = true;
      eula = true;
      openFirewall = true;
    };
  };
}
