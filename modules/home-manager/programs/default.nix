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

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    '';
    shellInit = ''
      fastfetch
    '';

    shellAliases = {
      cd = "z";
    };

    shellAbbrs = {
      ga = "git add";
      "ga." = "git add .";
      gp = "git pull";
      gc = "git commit -m";
    };
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };
}
