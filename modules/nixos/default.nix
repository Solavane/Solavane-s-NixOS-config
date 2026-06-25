{ config, lib, pkgs, ... }: {
  imports = [
    ./options.nix
    ./core/default.nix
    ./system/sddm.nix
    ./system/desktop/hyprland.nix
    ./system/desktop/mango.nix
    ./system/desktop/dms.nix
    ./programs/default.nix
    ./programs/pcmanfm.nix
    ./programs/steam.nix
    ./core/nvidia.nix
  ];
}
