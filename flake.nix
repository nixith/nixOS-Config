{
  description = "A useful config";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    Hyprland-Desktop-Portal = {
      url = "github:hyprwm/xdg-desktop-portal-hyprland";
    };

    Hyprland-Waybar = {
      url = "github:r-clifford/Waybar-Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };

    nix-colors = {
      url = "github:misterio77/nix-colors";
    };
  };



  outputs = { self, nixpkgs, hyprland, home-manager, nixos-hardware, nix-colors, ... } @ inputs:

    let
      system = "x86_64-linux";
      #nixpkgs.config.allowUnfree = true;
      pkgs = nixpkgs.legacyPackages.${system};
      user = "ryan";
    in
    {
      nixosConfigurations = import ./hosts {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs hyprland nixos-hardware user self;
      }; # Imports ./hosts/default.nix


      homeConfigurations = {

        Nebula = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };


          modules = [
            hyprland.homeManagerModules.default
            ./home/home.nix
          ];

          extraSpecialArgs = { inherit nix-colors; };

        };

        Galaxia = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };

          modules = [
            hyprland.homeManagerModules.default
            ./home/home.nix
          ];

          extraSpecialArgs = {
            inherit nix-colors;
            computer = "Galaxia";
          };

        };
      };

    };
}
