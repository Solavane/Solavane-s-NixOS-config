{ config, lib, pkgs, ... }:

let
  cfg = config.nixconf.nvidia;
in
lib.mkIf cfg.enable {

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable   = true;
    powerManagement.enable = false;          # enable if you see sleep/wake issues
    open             = false;                # open kernel module — not ready for RTX 30
    nvidiaSettings   = true;
    package          = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware.graphics.enable = true;

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME    = "nvidia";
    XDG_SESSION_TYPE     = "wayland";
    GBM_BACKEND          = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS  = "1";         # fix invisible cursor on NVIDIA/Wayland
  };
}
