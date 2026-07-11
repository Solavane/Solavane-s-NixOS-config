{ lib, config, ... }:

{
  options.nixconf = {

    # ----------------------------------------------------------
    # Host capability flags
    # ----------------------------------------------------------
    isDesktop = lib.mkOption {
      type    = lib.types.bool;
      default = false;
      description = "Whether this host is a desktop system. Gates all desktop modules.";
    };

    # ----------------------------------------------------------
    # Hardware
    # ----------------------------------------------------------
    nvidia.enable = lib.mkEnableOption "NVIDIA drivers (RTX 30+ / proprietary)";

    # ----------------------------------------------------------
    # Desktop environment modules
    # ----------------------------------------------------------
    desktop = {
      #sddm.enable     = lib.mkEnableOption "Enables SDDM login screen";
      hyprland.enable = lib.mkEnableOption "Hyprland compositor";
      mango = {
        enable   = lib.mkEnableOption "Mango Wayland Compositor";
        monitors = lib.mkOption {
          type    = lib.types.listOf lib.types.str;
          default = [];
        };
      };
      shell.enable = lib.mkEnableOption "Custom barless shell built with eww and fuzzel";
    };

    sddm.enable       = lib.mkEnableOption "login manager";

    # ----------------------------------------------------------
    # System-level programs
    # ----------------------------------------------------------
    programs = {
      kitty.enable      = lib.mkEnableOption "Kitty terminal";
      foot.enable       = lib.mkEnableOption "Foot lightweight terminal";
      pcmanfm.enable    = lib.mkEnableOption "pcmanfm file browser";
      librewolf.enable  = lib.mkEnableOption "LibreWolf browser";
      localsend.enable  = lib.mkEnableOption "easilly send files on local wifi";
      elinks.enable     = lib.mkEnableOption "Elinks text based browser";
      vesktop.enable    = lib.mkEnableOption "Vesktop Discord client";
      steam.enable      = lib.mkEnableOption "Steam game launcher client";
      faugus.enable     = lib.mkEnableOption "faugus games launcher";
    };

    services = {
      ollama.enable     = lib.mkEnableOption "Local LLM handeling";
    };

    # ----------------------------------------------------------
    # Theme
    # ----------------------------------------------------------
    font = lib.mkOption {
      type    = lib.types.str;
      default = "JetBrains Mono";
      description = "Primary monospace font.";
    };
  };

  # ----------------------------------------------------------
  # Automatic config handeling
  # ----------------------------------------------------------
  config = let
    cfg = config.nixconf;

    wmEnabled = cfg.desktop.hyprland.enable || cfg.desktop.mango.enable;
  in {
    
    # Enables shell if window manager is active
    nixconf.desktop.shell.enable = lib.mkIf wmEnabled true;
  };
}
