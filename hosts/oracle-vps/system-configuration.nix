{ config, lib, pkgs, ... }: {
  
  # System version on install. DO NOT CHANGE UNLESS YOU KNOW WHAT YOU'RE DOING!
  system.stateVersion = "25.11";

  # Bootloader.
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
    device = "nodev";
  };

  boot.initrd.availableKernelModules = [ "nvme" "virtio_pci" "virtio_scsi" "xhci_pci" ];

  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "prohibit-password";
  };

  networking.useDHCP = lib.mkDefault true;

  boot.kernelPackages = pkgs.linuxPackages_latest;
}
