{ config, lib, pkgs, inputs, ... }:

let
  cfg = config.nixconf.programs.steam;
in
{
  config = lib.mkIf (config.nixconf.isDesktop && cfg.enable) {

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };
  };
}
