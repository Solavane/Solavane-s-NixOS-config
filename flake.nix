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
      url = "github:mangowm/mango?ref=wl-only";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, stable-nixpkgs, nix-flatpak, home-manager, sops-nix, ... }@inputs:
  let
    mkHost = hostname: system: { desktop ? false }: nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; isDesktop = desktop; };
      modules = [
        ./hosts/${hostname}/default.nix
        ./modules/nixos/default.nix

        ({ config, ... }: {
          nixconf.isDesktop = nixpkgs.lib.mkDefault desktop;
        })

	      home-manager.nixosModules.home-manager
	      {
	        home-manager = {
	          useGlobalPkgs = true;
	          useUserPackages = true;
	          sharedModules = [ 
              ./modules/home-manager/default.nix 
              nix-flatpak.homeManagerModules.nix-flatpak 
              sops-nix.homeManagerModules.sops
            ];
	          extraSpecialArgs = { inherit inputs; };
	        };
      	}

        sops-nix.nixosModules.sops
      ];
    };
  in {
    nixosConfigurations = {
      PC           = mkHost "PC"           "x86_64-linux" { desktop = true; };
      old-laptop   = mkHost "old-laptop"   "x86_64-linux" { desktop = true; };
      dell-laptop  = mkHost "dell-laptop"  "x86_64-linux" { desktop = true; };
    };
  };
}
