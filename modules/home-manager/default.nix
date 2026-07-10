{ ... }:

{
  imports = [
    ./options.nix
    ./flatpak.nix
    ./desktop/hyprland/default.nix
    ./desktop/mango/default.nix
    ./desktop/eww.nix
    ./desktop/rofi.nix
    ./desktop/shell.nix
    ./programs/default.nix
    ./programs/blender.nix
    ./programs/btop.nix
    ./programs/fastfetch.nix
    ./programs/godot.nix
    ./programs/keepass.nix
    ./programs/prismlauncher.nix
    ./programs/cataclysm-dda.nix
    ./programs/nvim.nix
    ./programs/obs.nix
    ./programs/zellij.nix
    ./programs/zen-browser.nix
  ];
}
