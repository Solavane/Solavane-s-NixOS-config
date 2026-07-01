{ config, pkgs, ... }: {
  
  home = {
    username = "solavane";
    homeDirectory = "/home/solavane";
    stateVersion = "25.11";

    packages = with pkgs; [
      jamesdsp
    ];

  };

  nixconf = {
    
    programs = {
      zellij.enable = true;
    };
  
  };
}
