{
  lib,
  inputs,
  nixpkgs,
  nixos-hardware,
  self,
  user,
  hyprland,
  sops-nix,
  ...
}:
# This essentially extends the flake
# do hostname - lib.nixosSystem {} to define a config Make a subfolder for each config
# Build with nixos-rebuild --flake .#{configName} (I think)
let
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    config = {allowUnfree = true;};
    inherit system;
  };

  lib = nixpkgs.lib;
in {
  laptop = nixpkgs.lib.nixosSystem {
    # Laptop profile
    inherit system;

    modules = [
      sops-nix.nixosModules.sops

      ./laptop
      ./common/system.nix # Default shared options - mostly nix configurationa nd making sure I always have git
      ./common/desktop.nix # Default for graphical desktops
      ./common/tlp.nix
      ./common/security.nix

      hyprland.nixosModules.default
      {
        programs.hyprland = {
          enable = true;
          nvidiaPatches = true;
        };
      }
      nixos-hardware.nixosModules.lenovo-thinkpad-l13
    ];
    specialArgs = {inherit inputs user;};
  };
  desktop = nixpkgs.lib.nixosSystem {
    # Desktop profile
    inherit system;

    modules = [
      ./desktop
      ./common/kmscon.nix
      ./common/system.nix # Default shared options - mostly nix configurationa nd making sure I always have git
      ./common/desktop.nix # Default for graphical desktops
      ./common/security.nix
      ./common/virtualisation.nix

      hyprland.nixosModules.default
      {
        programs.hyprland = {
          enable = true;
          nvidiaPatches = true;
        };
      }
      #nixos-hardware.nixosModules.lenovo-thinkpad-l13
    ];
    specialArgs = {inherit inputs user;};
  };
}
