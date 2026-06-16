{ config, lib, pkgs, ... }: {
  
  # System version on install. DO NOT CHANGE UNLESS YOU KNOW WHAT YOU'RE DOING!
  system.stateVersion = "25.11";

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # File system settings. Is completely fine to edit, but old files may stay in the old state.
  fileSystems."/" = {
    options = [ "subvol=@" "compress=zstd:1" "noatime" "discard=async" ];
  };  
  fileSystems."/home" = {
    options = [ "subvol=@home" "compress=zstd:1" "noatime" ];
  };

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
    undervolt = {
      enable = true;
      coreOffset = -80;
    };

    flatpak.enable = true;

    lact.enable = true;

    fstrim.enable = true;

    udev.extraRules = ''
      # Set Kyber for NVMe
      ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/scheduler}="kyber"
      
      # Set BFQ for SATA SSDs/HDDs
      ACTION=="add|change", KERNEL=="sd[a-z]*", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="bfq"
    '';
  };
}
