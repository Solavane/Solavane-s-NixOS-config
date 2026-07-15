{ ... }:

{
  networking.firewall.enable = true;
  
  security.acme = {
    acceptTerms = true;
    defaults.email = "solavane@proton.me";
  };
}
