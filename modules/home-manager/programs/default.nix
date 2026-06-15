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

  home.packages = lib.mkIf p.foot.enable [
    pkgs.nerd-fonts.jetbrains-mono
  ];
  programs.foot = lib.mkIf p.foot.enable {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        font = "JetBrainsMono Nerd Font:size=11";

      };
    };
  };

  programs.neovim = {
    enable         = true;
    viAlias        = true;
    vimAlias       = true;
    defaultEditor  = true;
    waylandSupport = true;
    withRuby       = false;
    withPython3    = false;
    extraConfig = ''
      set termguicolors
      set number
      set tabstop=2
      set softtabstop=2
      set shiftwidth=2
      set expandtab
      set nocompatible
      set wildmode=longest,list
      set clipboard=unnamedplus 
    '';
    plugins = [
      {
        plugin = pkgs.vimPlugins.nvim-tree-lua;
	type = "lua";
        config = ''
          require('nvim-tree').setup()
        '';
      }
      {
        plugin = pkgs.vimPlugins.vim-startify;
        config = "let g:startify_change_to_vcs_root = 0";
      }
      {
        plugin = pkgs.vimPlugins.telescope-nvim;
        type = "lua"; 
        config = ''
          require('telescope').setup()
          
          vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, {})
          vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, {})
        '';
      }
    ];
  };
}
