{ config, lib, osConfig, pkgs, ... }: {

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
        type = "viml";
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
      {
        plugin = pkgs.vimPlugins.indent-blankline-nvim;
        type = "lua";
        config = ''
          require("ibl").setup({
            indent = {
              char = "│",
            },
            scope = {
              enabled = true;
              show_start = false;
              show_end = false;
            },
          })        
        '';
      }
    ];
  };
}
