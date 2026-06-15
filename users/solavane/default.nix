{ pkgs, ... }:
{
  users.users.solavane = {
    isNormalUser     =  true;
    extraGroups      =  [ "wheel" "video" "audio" "networkmanager" ];
    initialPassword  =  "123";
  };
}
