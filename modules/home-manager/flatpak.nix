{ config, lib, ... }: 

let
  p = config.nixconf.flatpaks;
in {

  services.flatpak = {

    remotes = lib.mkOptionDefault [{
      name = "flathub-beta"; 
      location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
    }];

    packages = 
      lib.optionals p.sober.enable    [ "org.vinegarhq.Sober" ];
  };
}
