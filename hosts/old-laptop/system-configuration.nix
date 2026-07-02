{ config, lib, pkgs, ... }: {
  
  # System version on install. DO NOT CHANGE UNLESS YOU KNOW WHAT YOU'RE DOING!
  system.stateVersion = "25.11";

  # Bootloader.
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
  };

  # File system settings. Is completely fine to edit, but old files may stay in the old state.
  #fileSystems."/" = {
  #  options = [ "subvol=@" "noatime" "discard=async" ];
  #};  

  environment.systemPackages = with pkgs; [
    acpi #Laptop battery analyser
  ];

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
