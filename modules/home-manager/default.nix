{ ... }:

{
  imports = [
    ./options.nix
    ./flatpak.nix
    ./desktop/hyprland/default.nix
    ./desktop/mango/default.nix
    ./desktop/awww.nix
    ./theming/default.nix
    ./programs/default.nix
    ./programs/fastfetch.nix
    ./programs/prismlauncher.nix
    ./programs/cataclysm-dda.nix
    ./programs/nvim.nix
    ./programs/obs.nix
  ];
}
