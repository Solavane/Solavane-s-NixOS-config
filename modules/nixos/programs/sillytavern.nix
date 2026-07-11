{ config, lib, pkgs, inputs, ... }:

let
  cfg = config.nixconf.programs.sillytavern;
in
{
  config = lib.mkIf (config.nixconf.isDesktop && cfg.enable) {

    services.sillytavern = {
      enable = true;
      port = 8045;
      listenAddressIPv4 = "127.0.0.1";
      configFile = "/var/lib/SillyTavern/data/config.yaml";
    };
  };
}
