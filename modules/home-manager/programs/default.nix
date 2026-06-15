{ config, lib, osConfig, pkgs, ... }:

let
  p = osConfig.nixconf.programs;
in {

  programs.kitty = lib.mkIf p.kitty.enable {
    enable    = true;
    font.name = osConfig.nixconf.font;
    font.size = 13;
    settings  = {
      scrollback_lines        = 10000;
      enable_audio_bell       = false;
      confirm_os_window_close = 0;
    };
  };

  programs.neovim = {
    enable         = true;
    viAlias        = true;
    vimAlias       = true;
    defaultEditor  = true;
    waylandSupport = true;
    extraConfig = ''
      set number
      set tabstop=2
      set softtabstop=2
      set expandtab
      set nocompatible
      set wildmode=longest,list
      set clipboard=unnamedplus 
    '';
  };
  # Add profiles, extensions etc. here later.
}
