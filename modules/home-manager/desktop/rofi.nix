{ ... }: {
  
  #xdg.configFile."rofi/scripts" = {
  #  source = ./scripts/rofi;
  #  recursive = true;
  #};

  programs.rofi = {
    terminal = "\${pkgs.foot}/bin/foot";
    modes = [
      "drun"
      "emoji"
      "window"
      "filebrowser"
    ];
  };
}
