{ config, lib, osConfig, ... }:

let
  enabled = osConfig.nixconf.desktop.mango.enable;
  monitors = lib.concatMapStrings (m: "monitorrule=${m}\n") osConfig.nixconf.desktop.mango.monitors;

in
{
  config = lib.mkIf enabled {
    
    xdg.configFile."mango/config.conf" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixconfig/modules/home-manager/desktop/mango/config.conf"; 
      #THIS WILL CAUSE PROBLEMS IF FILE OR PROJECT IS MOVED IN ANY WAY, Also config file folder must be called nixconfig
    };

    xdg.configFile."mango/stock-binds.conf" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixconfig/modules/home-manager/desktop/mango/stock-binds.conf"; 
      #THIS WILL CAUSE PROBLEMS IF FILE OR PROJECT IS MOVED IN ANY WAY, Also config file folder must be called nixconfig
    };

    xdg.configFile."mango/scripts" = {
      source = ./scripts;
      recursive = true;
    };

    xdg.configFile."mango/binds.conf".text = ''
      # Custom app bind
      bind=SUPER,b,spawn,librewolf
      bind=SUPER+CTRL,b,spawn,foot elinks
      bind=SUPER+Ctrl,d,spawn,vesktop
      bind=SUPER+Ctrl,s,spawn,foot spotify_player
    '';

    xdg.configFile."mango/env.conf".text = ''
      
    '';

    xdg.configFile."mango/monitors.conf".text = monitors;

  };
}
