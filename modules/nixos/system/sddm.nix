{ config, lib, pkgs, inputs, ... }:

let
  cfg = config.nixconf.sddm;
in
{
  config = lib.mkIf (config.nixconf.isDesktop && cfg.enable) {
    services.displayManager.sddm = {
      enable = true;
      extraPackages = [ 
        (pkgs.sddm-astronaut.override {
          embeddedTheme = "hyprland_kath";
        })
      ];
      theme = "sddm-astronaut-theme";

      # Enables experimental Wayland support
      wayland.enable = true;
    };
    
    environment.systemPackages = with pkgs; [
      (sddm-astronaut.override {
        embeddedTheme = "hyprland_kath";
      })
      kdePackages.qtmultimedia
    ];
  };
}
