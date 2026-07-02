{ ... }: {
  
  xdg.configFile."fuzzel/scripts" = {
    source = ./scripts/fuzzel;
    recursive = true;
  };

}
