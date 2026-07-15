  { lib, config, ... }: {

  config = lib.mkIf config.nixconf.isDesktop {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;

      # Dragonfly volume jumpscare fix
      wireplumber.extraConfig."50-alsa-config" = {
        "monitor.alsa.rules" = [
          {
            matches = [
              {
                # Target the output node stream rather than the hardware card
                "node.name" = "~alsa_output.usb-AudioQuest*";
              }
            ];
            actions = {
              update-props = {
                "api.alsa.ignore-dB" = true;
                "api.alsa.soft-mixer" = true;
              };
            };
          }
        ];
      };
    };
  };
}

