{ config, lib, pkgs, ... }:

let
  cfg = config.nixconf.desktop.attract-mode;
in
lib.mkIf (config.nixconf.isDesktop && cfg.enable) {
  
  # Custom ES-DE session using gamescope.
  services.displayManager.sessionPackages = [
    (pkgs.writeTextFile {
      name = "retro-games-session";
      destination = "/share/wayland-sessions/retro-games.desktop";
      text = ''
        [Desktop Entry]
        Name=Retro Games
        DesktopNames=Retro Games
        Exec=${pkgs.dbus}/bin/dbus-run-session -- ${pkgs.gamescope}/bin/gamescope -f -- ${pkgs.attract-mode}/bin/attract
        Type=Application
      '';
      passthru.providedSessions = [ "retro-games" ];
    })
  ];
}
