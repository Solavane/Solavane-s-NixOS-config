{ ... }:

{
  networking.firewall.enable = true;
  
  security.acme = {
    acceptTerms = true;
    defaults.email = "solavane@proton.me";
  };

  # is end of life but I guess Element uses it...
  nixpkgs.config.permittedInsecurePackages = [
    "electron-40.10.5"
  ];
}
