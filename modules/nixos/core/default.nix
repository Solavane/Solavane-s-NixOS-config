{ pkgs, lib, config, ... }:

{
  # -------------------------------------------------------
  # Locale & time
  # -------------------------------------------------------
  time.timeZone              = "Europe/Stockholm";
  i18n.defaultLocale         = "en_US.UTF-8";

  # -------------------------------------------------------
  # Nix settings
  # -------------------------------------------------------
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store   = true;
  };

  nixpkgs.config.allowUnfree = true; 

  # -------------------------------------------------------
  # Base packages every host gets
  # -------------------------------------------------------
  environment.systemPackages = with pkgs; [
    neovim
    nitch
    p7zip
    p7zip-rar
    wget
    curl
    ripgrep
    jq
    sops
    zip
    unzip
    (python3.withPackages (ps: with ps; [ 
      pywebview 
      pygobject3
    ]))
  ];

  users.defaultUserShell = pkgs.zsh;

  programs = {
    git.enable  = true;
    zsh.enable  = true;
    tmux.enable = true;

    
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/solavane/nixconfig"; # Change this depending on who has the configuration file for nh support
    };

  };

  services = {
    ntp.enable = true;
    gvfs.enable = true;
  };

  # -------------------------------------------------------
  # Desktop-only options, disabled on servers
  # -------------------------------------------------------

  #qt.enable = lib.mkIf config.nixconf.isDesktop true;

}
