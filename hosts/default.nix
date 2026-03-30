{
  config,
  # flakeProgramsSqlite,
  ...
}:
# This essentially extends the flake
# do hostname - lib.nixosSystem {} to define a config Make a subfolder for each config
# Build with nixos-rebuild --flake .#{configName} (I think)
let
  user = config.nixith.user;
  pins = import ../npins;
  niri-flake-repo = pins.niri;
  compat = import pins.flake-compat;

  niri = compat.load {
    src = niri-flake-repo;
  };

  system = "x86_64-linux";
  pkgs = import pins.nixpkgs {
    config = {
      allowUnfree = true;
    };
    inherit system;
  };

  common = [
    ./module.nix
    {
      nix.settings = {
        trusted-substituters = [
          "https://hydra.nixos.org/"
          "https://cache.nixos.org/"
          "https://nix-community.cachix.org"
          "https://anyrun.cachix.org"
          "https://cuda-maintainers.cachix.org"
          "https://niri.cachix.org"
        ];
        trusted-public-keys = [
          "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs="
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
          "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
          "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
        ];

      };
    }
    "${pins.home-manager}/nixos"
    (
      { config, ... }:
      {
        home-manager = {
          backupFileExtension = "backup";
          useGlobalPkgs = true;
          users.${user} = import ./modules/home.nix {
            inherit
              user
              pkgs
              ;
          };
        };
      }
    )
    {
      nix.registry.nixpkgs.to = {
        type = "path";
        path = pins.nixpkgs;
      };

      nix.channel.enable = false;
      nix.nixPath = [ "nixpkgs=${pins.nixpkgs}:" ];
    }
    {
      nixpkgs.overlays =

        [
          (import (pins.nixivim)).overlays.default
          niri.overlays.niri
        ];
      environment.systemPackages = [ niri.packages.${pkgs.stdenv.hostPlatform.system}.xwayland-satellite-unstable ];
      programs.niri = {
        enable = true;
        package = niri.packages.${pkgs.stdenv.hostPlatform.system}.niri-unstable;
      };
    }
    ./modules/run0.nix
    "${pins.sops-nix}/modules/sops"
    {
      programs.thunderbird = {
        enable = true;
      };
    }
    ./modules/console.nix
    ./common/yubikey.nix
    ./modules/tailscale.nix
    ./modules/wireshark.nix
    ./common/system.nix # Default shared options - mostly nix configurationa nd making sure I always have git
    ./common/desktop.nix # Default for graphical desktops
    ./common/security.nix
    ./modules/stylix.nix
    ./common/virtualisation.nix
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
    "${pins.nix-index-database}/nixos-module.nix"
    {
      programs.nix-index-database.comma.enable = true;
    }
    (
      { config, ... }:
      pkgs.lib.mkIf config.home-manager.users.${user}.xdg.portal.enable {
        environment.pathsToLink = [
          "/share/xdg-desktop-portal"
          "/share/applications"
        ];
      }
    )
  ];
in
{

  imports = common;
  # laptop = pkgs.lib.nixosSystem {
  #   # Laptop profile
  #   inherit system;
  #
  #   modules = [
  #     ./laptop
  #   ]
  #   ++ common;
  #   specialArgs = { inherit user self; };
  # };
  #
  # desktop = pkgs.lib.nixosSystem {
  #   # Desktop profile
  #   inherit system;
  #
  #   modules = [
  #     ./desktop
  #     { config.facter.reportPath = ./desktop/facter.json; }
  #
  #     # ./common/kmscon.nix # alternate tty, need to figure out how to turn off gpu so wayland can take it
  #     ./common/system.nix # Default shared options - mostly nix configurationa nd making sure I always have git
  #     ./common/desktop.nix # Default for graphical desktops
  #     ./common/security.nix
  #     ./common/secrets.nix
  #     ./common/system76-scheduler.nix
  #     ./common/virtualisation.nix
  #     ./modules/tailscale.nix
  #     ./modules/stylix.nix
  #   ]
  #   ++ common;
  #   specialArgs = { inherit user; };
  # };
}
