{
  lib,
  inputs,
  nixpkgs,
  user,
  hyprland,
  self,
  home-manager,
  ...
}: let
  system = "x86_64-linux";
  pkgs = nixpkgs.legacyPackages.${system};

  shared = [sops-nix.nixosModules.sops];
in {
  "ryan@nixos" = home-manager.lib.homeManagerConfiguration rec {
    inherit pkgs;
    inherit system;

    modules =
      [
        hyprland.homeManagerModules.default
        ./home.nix
      ]
      ++ shared;

    configuration = import ./home.nix;

    home-manager.extraSpecialArgs = {
      inherit user;
      inherit self;
    }; # Pass flake variable

    extraSpecialArgs.flake-inputs = inputs;
    homeDirectory = "/home/ryan/";
    username = "ryan";
  };
}
