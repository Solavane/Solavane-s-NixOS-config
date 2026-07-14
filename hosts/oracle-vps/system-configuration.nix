{ config, lib, pkgs, ... }: {
  
  # System version on install. DO NOT CHANGE UNLESS YOU KNOW WHAT YOU'RE DOING!
  system.stateVersion = "25.11";

  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
    initrd.systemd.enable = true;
  };

  boot.initrd.availableKernelModules = [ "nvme" "virtio_pci" "virtio_scsi" "usbhid" "xhci_pci" ];

  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "prohibit-password";
  };

  # Enable passwordless sudo.
  security.sudo.extraRules = [
    {
      users = [ solavane ];
      commands = [
        {
          command = "ALL";
          options = ["NOPASSWD"];
        }
      ];
    }
  ];

  # Disable documentation for minimal install.
  documentation.enable = false;

  networking.useDHCP = lib.mkDefault true;
  networking.firewall.allowedTCPPorts = [ 22 ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
}
