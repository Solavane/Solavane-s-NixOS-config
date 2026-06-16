{

  description = "Solavane's Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stable-nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    mango = {
      url = "github:mangowm/mango"; #?ref=wl-only
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { nixpkgs, stable-nixpkgs, nix-flatpak, home-manager, ... }@inputs:
  let
    mkHost = hostname: system: { desktop ? false }: nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/${hostname}/default.nix
        ./modules/nixos/default.nix
	      home-manager.nixosModules.home-manager
	      {
	        home-manager = {
	          useGlobalPkgs = true;
	          useUserPackages = true;
	          sharedModules = [ 
              ./modules/home-manager/default.nix 
              nix-flatpak.homeManagerModules.nix-flatpak 
            ];
	          extraSpecialArgs = { inherit inputs; };
	          #backupFileExtension = "backup";
	        };
      	}
      ];
    };
  in {
    nixosConfigurations = {
      PC         = mkHost "PC"         "x86_64-linux" { desktop = true; };
      old-laptop = mkHost "old-laptop" "x86_64-linux" { desktop = true; };
    };
  };
}
