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
    inherit system self inputs;
  };

  common = [
    inputs.flakeProgramsSqlite.nixosModules.programs-sqlite
    inputs.sops-nix.nixosModules.sops
    ./modules/console.nix
  ];

  lib = nixpkgs.lib;
in {
  laptop = nixpkgs.lib.nixosSystem {
    # Laptop profile
    inherit system;

    modules =
      [
        ./laptop
        ./modules/tailscale.nix
        #./modules/firefox.nix
        #./modules/calibre.nix
        ./common/system.nix # Default shared options - mostly nix configurationa nd making sure I always have git
        ./common/desktop.nix # Default for graphical desktops
        ./common/tlp.nix
        ./common/secrets.nix
        ./common/security.nix
        ./common/virtualisation.nix

        hyprland.nixosModules.default
        {
          programs.hyprland = {
            enable = true;
            portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
            package = inputs.hyprland.packages.${pkgs.system}.hyprland;
          };
        }
        inputs.niri.nixosModules.niri
        {
          programs.niri.enable = true;
        }
        nixos-hardware.nixosModules.lenovo-thinkpad-l13
      ]
      ++ common;
    specialArgs = {inherit inputs user;};
  };
  desktop = nixpkgs.lib.nixosSystem {
    # Desktop profile
    inherit system;

    modules =
      [
        ./desktop
        ./modules/greetd.nix

        # ./common/kmscon.nix # alternate tty, need to figure out how to turn off gpu so wayland can take it
        ./common/system.nix # Default shared options - mostly nix configurationa nd making sure I always have git
        ./common/desktop.nix # Default for graphical desktops
        ./common/security.nix
        ./common/secrets.nix
        ./common/virtualisation.nix
        ./modules/tailscale.nix

        hyprland.nixosModules.default
        {
          programs.hyprland = {
            enable = true;
            package = inputs.hyprland.packages.${pkgs.system}.hyprland;
            portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
          };
        }
        #nixos-hardware.nixosModules.lenovo-thinkpad-l13
      ]
      ++ common;
    specialArgs = {inherit inputs user;};
  };
}
