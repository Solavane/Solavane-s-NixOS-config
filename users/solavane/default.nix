{ pkgs, ... }:
{
  users.users.solavane = {
    isNormalUser     =  true;
    shell = pkgs.zsh;
    extraGroups      =  [ "wheel" "video" "audio" "networkmanager" ];
    initialPassword  =  "123";
  };
}
