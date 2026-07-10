{ config, osConfig, lib, pkgs, ... }:

let
  cfg = config.nixconf.services.syncthing;
  devicesFile = /. + "${config.home.homeDirectory}/.secret/nix/syncthing-devices.nix";
in

{
  config = lib.mkIf cfg.enable {
    sops.secrets.syncthing-password-solavane = {};

    services.syncthing = {
      enable = true;

      guiCredentials = {
        username        = config.home.username;
        passwordFile    = config.sops.secrets.syncthing-password-solavane.path;
      };
      settings = {
        devices = lib.optionalAttrs (builtins.pathExists devicesFile) (import devicesFile);
        folders = {
          secrets = {
            path = "${config.home.homeDirectory}/.secrets/sync";
            devices = lib.attrNames (lib.optionalAttrs (builtins.pathExists devicesFile) (import devicesFile));
          };
        };
      };
    };
  };
}
