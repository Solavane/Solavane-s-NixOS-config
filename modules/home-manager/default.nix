{ ... }:

{
  imports = [
    ./options.nix
    ./flatpak.nix
    ./desktop/hyprland/default.nix
    ./desktop/mango/default.nix
    ./desktop/awww.nix
    ./desktop/eww.nix
    ./desktop/rofi.nix
    ./desktop/shell.nix
    ./theming/default.nix
    ./programs/default.nix
    ./programs/blender.nix
    ./programs/fastfetch.nix
    ./programs/godot.nix
    ./programs/prismlauncher.nix
    ./programs/cataclysm-dda.nix
    ./programs/nvim.nix
    ./programs/obs.nix
    ./programs/zellij.nix
  ];
}
