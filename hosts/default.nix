{
  inputs,
  nixpkgs,
  nixos-hardware,
  self,
  user,
  home-manager,
  niri,
  # flakeProgramsSqlite,
  ...
}:
# This essentially extends the flake
# do hostname - lib.nixosSystem {} to define a config Make a subfolder for each config
# Build with nixos-rebuild --flake .#{configName} (I think)
let
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    config = {
      allowUnfree = true;
    };
    inherit system self inputs;
  };

  common = [
    home-manager.nixosModules.default
    (
      { config, ... }:
      {
        home-manager = {
          backupFileExtension = "backup";
          useGlobalPkgs = true;
          users.${user} = import ./modules/home.nix {
            inherit
              self
              user
              pkgs
              inputs
              ;
          };
        };
      }
    )
    {
      nixpkgs.overlays = [ niri.overlays.niri ] ++ overlays;
      environment.systemPackages = [ niri.packages.${pkgs.system}.xwayland-satellite-unstable ];
      programs.niri = {
        enable = true;
        package = niri.packages.${pkgs.system}.niri-unstable;
      };
    }
    ./modules/run0.nix
    inputs.sops-nix.nixosModules.sops
    {
      programs.thunderbird = {
        enable = true;
      };
    }
    ./modules/console.nix
    ./common/yubikey.nix
    # flakeProgramsSqlite.nixosModules.programs-sqlite
    (
      { pkgs, ... }:
      {
        nixpkgs.overlays = [
          (final: prev: {
            inherit (prev.lixPackageSets.stable)
              nixpkgs-review
              nix-eval-jobs
              nix-fast-build
              colmena
              ;
          })
        ];

        nix.package = pkgs.lixPackageSets.stable.lix;
      }
    )
    ./modules/greetd.nix
    inputs.nix-index-database.nixosModules.nix-index
    {
      programs.nix-index-database.comma.enable = true;
    }
    (
      { config, user, ... }:
      lib.mkIf config.home-manager.users.${user}.xdg.portal.enable {
        environment.pathsToLink = [
          "/share/xdg-desktop-portal"
          "/share/applications"
        ];
      }
    )
  ];

  overlays = [ inputs.nixivim.overlays.default ];

  inherit (nixpkgs) lib;
in
{
  laptop = nixpkgs.lib.nixosSystem {
    # Laptop profile
    inherit system;

    modules = [
      ./laptop
      ./modules/iwd.nix
      ./modules/wireshark.nix
      ./modules/networkd.nix
      ./modules/tailscale.nix
      ./modules/firefox.nix
      #./modules/calibre.nix
      ./common/system.nix # Default shared options - mostly nix configurationa nd making sure I always have git
      ./common/desktop.nix # Default for graphical desktops
      # ./common/tlp.nix
      ./common/secrets.nix
      ./common/security.nix
      ./common/virtualisation.nix
      ./modules/stylix.nix
      inputs.disko.nixosModules.disko
      ./laptop/disko.nix
      nixos-hardware.nixosModules.framework-12th-gen-intel
      {
        hardware.fw-fanctrl = {
          enable = true;
        };
      }
      # {
      #   programs.river.enable = true;
      #   environment.systemPackages = with pkgs; [ rivercarro ];
      # }
    ]
    ++ common;
    specialArgs = { inherit inputs user self; };
  };
  desktop = nixpkgs.lib.nixosSystem {
    # Desktop profile
    inherit system;

    modules = [
      ./desktop
      inputs.nixos-facter-modules.nixosModules.facter
      { config.facter.reportPath = ./desktop/facter.json; }

      ./modules/firefox.nix
      # ./common/kmscon.nix # alternate tty, need to figure out how to turn off gpu so wayland can take it
      ./common/system.nix # Default shared options - mostly nix configurationa nd making sure I always have git
      ./common/desktop.nix # Default for graphical desktops
      ./common/security.nix
      ./common/secrets.nix
      ./common/system76-scheduler.nix
      ./common/virtualisation.nix
      ./modules/tailscale.nix
      ./modules/stylix.nix
    ]
    ++ common;
    specialArgs = { inherit inputs user; };
  };
}
