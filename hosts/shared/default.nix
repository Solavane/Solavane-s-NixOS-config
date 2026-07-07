{ ... }:

{
  services.openssh = {
    enable                = false;
    settings.PermitRootLogin = "no";
  };

  networking.firewall.enable = true;
}
