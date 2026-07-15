{ config, lib, pkgs, ... }: {
  imports = [
    ./options.nix
    ./core/default.nix
    ./system/sddm.nix
    ./system/desktop/hyprland.nix
    ./system/desktop/mango.nix
    ./system/desktop/shell.nix
    ./programs/default.nix
    ./programs/localsend.nix
    ./programs/pcmanfm.nix
    ./programs/sillytavern.nix
    ./programs/steam.nix
    ./core/nvidia.nix
    ./hosting/minecraft/default.nix
    ./services/ollama.nix
    ./services/pipewire.nix
  ];
}
