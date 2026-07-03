{ ... }: {
  
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;

    user = "solavane";
    configDir = "/home/solavane/.config/syncthing";
    settings = {
      gui.user = "solavane";
    };
  };

  networking.firewall.allowedTCPPorts = [ 8384 ];
}
