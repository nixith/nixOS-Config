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
      user = "ryan" ;
    in {
# Stop here for the day. Revisit later with more
# videos, and maybe redo hyprland section
# and revisit if this is how you want
# the config structured

