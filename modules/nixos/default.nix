{ config, lib, pkgs, ... }: {
  imports = [
    ./options.nix
    ./core/default.nix
    ./system/plymouth.nix
    ./system/sddm.nix
    ./system/desktop/attract-mode.nix
    ./system/desktop/hyprland.nix
    ./system/desktop/mango.nix
    ./system/desktop/shell.nix
    ./programs/default.nix
    ./programs/localsend.nix
    ./programs/pcmanfm.nix
    ./programs/sillytavern.nix
    ./programs/steam.nix
    ./core/nvidia.nix
    ./hosting/ddns/default.nix
    ./hosting/matrix/default.nix
    ./hosting/minecraft/default.nix
    ./hosting/webserver/default.nix
    ./hosting/homepage.nix
    ./services/ollama.nix
    ./services/pipewire.nix
  ];
}
