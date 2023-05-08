{
  description = "A useful config";

  nixConfig = {
    # allow building without passing flags on first run
    extra-experimental-features = "nix-command flakes";
    # Add me to trusted users
    trusted-users = ["root" "@wheel" "ryan"];

    # Grab binaries faster from sources
    substituters = [
      "https://cache.nixos.org/"
      "https://hyprland.cachix.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    http-connections = 0; #No limit on number of connections

    # nix store optimizations
    auto-optimise-store = true;
    allowUnfree = true;
  };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    sops-nix.url = "github:Mic92/sops-nix";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    prismlauncher = {
      url = "github:prismlauncher/prismlauncher";
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

    nixos-hardware = {url = "github:NixOS/nixos-hardware/master";};

    nix-colors = {url = "github:misterio77/nix-colors";};
    nix-doom-emacs = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/nix-doom-emacs";
    };
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nil = {url = "github:oxalica/nil";};
    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    sops-nix,
    hyprland,
    home-manager,
    nixos-hardware,
    nix-colors,
    nix-doom-emacs,
    neovim-nightly-overlay,
    alejandra,
    prismlauncher,
    emacs-overlay,
    Hyprland-Desktop-Portal,
    Hyprland-Waybar,
    #Too remove later
    nil,
    #gets latest version of nil
    ...
  } @ inputs: let
    system = "x86_64-linux";

    #nixpkgs.config.allowUnfree = true;
    user = "ryan";
    overlays = [
      neovim-nightly-overlay.overlay
      (self: super: {
        discord = super.discord.override {withOpenASAR = true;};
      })
      emacs-overlay.overlay
    ];
  in {
    formatter.x86_64-linux = alejandra.defaultPackage.${system};
    nixosConfigurations = import ./hosts {
      inherit (nixpkgs) lib;
      inherit inputs nixpkgs hyprland nixos-hardware user self sops-nix;
      specialArgs.inputs = inputs;
    }; # Imports ./hosts/default.nix

    homeConfigurations = {
      nixpkgs.overlays = overlays;

      Nebula = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        modules = [
          hyprland.homeManagerModules.default
          nix-doom-emacs.hmModule
          ./home/home.nix
        ];

        extraSpecialArgs = {
          inherit nix-colors self;
          computer = "Nebula";
          inherit overlays system;
          inherit alejandra neovim-nightly-overlay prismlauncher;
        };
      };

      Galaxia = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        modules = [
          hyprland.homeManagerModules.default
          nix-doom-emacs.hmModule
          ./home/home.nix
        ];

        extraSpecialArgs = {
          inherit nix-colors;
          computer = "Galaxia";
          inherit overlays system;
          inherit alejandra neovim-nightly-overlay prismlauncher;
        };
      };
    };
  };
}
