{ inputs, nixpkgs, nixos-hardware, self, user, hyprland, home-manager, niri
, flakeProgramsSqlite, ... }:
# This essentially extends the flake
# do hostname - lib.nixosSystem {} to define a config Make a subfolder for each config
# Build with nixos-rebuild --flake .#{configName} (I think)
let
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    config = { allowUnfree = true; };
    inherit system self inputs;
  };

  common = [
    inputs.sops-nix.nixosModules.sops
    ./modules/console.nix
    flakeProgramsSqlite.nixosModules.programs-sqlite
  ];

  inherit (nixpkgs) lib;
in {
  laptop = nixpkgs.lib.nixosSystem {
    # Laptop profile
    inherit system;

    modules = [
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
        programs = {
          hyprland = {
            enable = true;
            portalPackage =
              inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
            package = inputs.hyprland.packages.${pkgs.system}.hyprland;
          };
          hyprlock.enable = true;
        };
      }
      home-manager.nixosModules.default
      {
        home-manager.backupFileExtension = "backup";

        home-manager.useGlobalPkgs = true;
        home-manager = {
          users.${user} = import ./desktop/home.nix { inherit self user pkgs; };
        };
      }
      nixos-hardware.nixosModules.lenovo-thinkpad-l13
    ] ++ common;
    specialArgs = { inherit inputs user self; };
  };
  desktop = nixpkgs.lib.nixosSystem {
    # Desktop profile
    inherit system;

    modules = [
      ./desktop
      ./modules/greetd.nix
      # ./common/kmscon.nix # alternate tty, need to figure out how to turn off gpu so wayland can take it
      ./common/system.nix # Default shared options - mostly nix configurationa nd making sure I always have git
      ./common/desktop.nix # Default for graphical desktops
      ./common/security.nix
      ./common/secrets.nix
      ./common/system76-scheduler.nix
      ./common/virtualisation.nix
      ./modules/tailscale.nix

      inputs.lix.nixosModules.default
      hyprland.nixosModules.default
      {
        programs = {
          hyprland = {
            enable = true;
            package = inputs.hyprland.packages.${pkgs.system}.hyprland;
            portalPackage =
              inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
          };
          hyprlock.enable = true;
        };
      }
      home-manager.nixosModules.default
      {
        home-manager.backupFileExtension = "backup";

        home-manager.useGlobalPkgs = true;
        home-manager = {
          users.${user} = import ./desktop/home.nix { inherit self user pkgs; };
        };
      }
      {
        nixpkgs.overlays = [ niri.overlays.niri ];
        environment.systemPackages =
          [ niri.packages.${pkgs.system}.xwayland-satellite ];
      }
      #nixos-hardware.nixosModules.lenovo-thinkpad-l13
    ] ++ common;
    specialArgs = { inherit inputs user; };
  };
}
