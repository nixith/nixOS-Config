{  description = "A useful config";
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
  };



  outputs = inputs @ { self, nixpkgs, hyprland, home-manager, ... }:
    let
      pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
      };
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      user = ryan;
    in {

      nixosConfigurations = {
        nixos = lib.nixosSystem {
          import ./hosts/{
            inherit (nixpkgs) lib;
            inherit inputs user system home-manager;
          };
        };
      };
    };
}
