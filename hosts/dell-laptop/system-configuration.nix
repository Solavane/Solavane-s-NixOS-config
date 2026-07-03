{ config, lib, pkgs, ... }: {
  
  # System version on install. DO NOT CHANGE UNLESS YOU KNOW WHAT YOU'RE DOING!
  system.stateVersion = "25.11";

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

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

  boot.kernelPackages = pkgs.linuxPackages_zen;

  services = {
    flatpak.enable = true;
    
    fstrim.enable = true;
  };

  networking.networkmanager.enable = true;

}
