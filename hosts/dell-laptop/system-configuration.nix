{ config, lib, pkgs, ... }: {
  
  # System version on install. DO NOT CHANGE UNLESS YOU KNOW WHAT YOU'RE DOING!
  system.stateVersion = "25.11";

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # File system settings. Is completely fine to edit, but old files may stay in the old state.
  #fileSystems."/" = {
  #  options = [ "subvol=@" "noatime" "discard=async" ];
  #};  

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.networkmanager.enable = true;

}
