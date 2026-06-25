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
    htop
    p7zip
    p7zip-rar
    tree
    wget
    curl
    ripgrep
    jq
    zip
    unzip
    (python3.withPackages (ps: with ps; [ 
      pywebview 
      pygobject3
    ]))
  ];

  programs.git.enable = true;

  services.ntp.enable = true;
  services.gvfs.enable = true;

  # -------------------------------------------------------
  # User shell
  # -------------------------------------------------------
  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  # -------------------------------------------------------
  # Desktop-only options, disabled on servers
  # -------------------------------------------------------

  #qt.enable = lib.mkIf config.nixconf.isDesktop true;

}
