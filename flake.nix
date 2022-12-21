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



  outputs = { self, nixpkgs, hyprland, home-manager, ... }: {
    let
    
      pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
      };

      system = "x86_64-linux";

      lib = nixpkgs.lib;
    in {

      nvidia = builtins.getEnv "NVIDIA" != "";

      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
          inherit nvidia;
          modules = [
            ./configuration.nix
            ./modules/Hardware/nvidia.nix
            ];
          if nvidia then gpuConfig else [ ];
        };
      };
    };
  };
}
