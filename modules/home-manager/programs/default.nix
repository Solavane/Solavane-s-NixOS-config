{ lib, osConfig, pkgs, ... }:

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

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    setOptions = [
      "HIST_IGNORE_ALL_DUPS"
    ];

    initContent = ''
      nitch
    '';

    shellAliases = {
      cd = "z";
      ls = "eza -l --icons";
      tree = "eza --tree";
      
      "ga." = "git add .";
    };
    
    # plugin manager
    oh-my-zsh = {
      enable = true;
      plugins = [
        "alias-finder"
        "gitfast"
      ];
      theme = "robbyrussell";
    };
  };

  programs.zoxide = {
    # cd replacement, learns common paths to make cding faster
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    # fuzzy search command
    enable = true;
    enableZshIntegration = true;
  };

  programs.eza = {
    # has prettier ls and tree commands
    enable = true;
    enableZshIntegration = true;
  };
}
