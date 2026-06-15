{ ... }:

{
  imports = [
    ./options.nix
    ./desktop/hyprland/default.nix
    ./desktop/mango/default.nix
    ./desktop/awww.nix
    ./theming/default.nix
    ./programs/default.nix
    ./programs/prismlauncher.nix
    ./programs/obs.nix
  ];
}
