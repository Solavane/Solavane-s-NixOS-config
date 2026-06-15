{ ... }:

{
  services.openssh = {
    enable                = false;   # flip to true on servers
    settings.PermitRootLogin = "no";
  };

  networking.firewall.enable = true;
}
