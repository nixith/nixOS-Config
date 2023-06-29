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
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flakeProgramsSqlite = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "nixpkgs/nixos-unstable";

    sops-nix.url = "github:Mic92/sops-nix";

    anyrun.url = "github:Kirottu/anyrun";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.url = "nixpkgs/nixos-unstable";
    };

    #prismlauncher = {
    #  url = "github:prismlauncher/prismlauncher";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    Hyprland-Desktop-Portal = {
      url = "github:hyprwm/xdg-desktop-portal-hyprland";
    };

    Hyprland-Waybar = {
      url = "github:r-clifford/Waybar-Hyprland";
      #inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {url = "github:NixOS/nixos-hardware/master";};

    nix-colors = {url = "github:misterio77/nix-colors";};

    nil = {url = "github:oxalica/nil";};
    nixd = {url = "github:nix-community/nixd";};

    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    fenix,
    nixpkgs,
    sops-nix,
    hyprland,
    home-manager,
    nixos-hardware,
    nix-colors,
    neovim-nightly-overlay,
    alejandra,
    #prismlauncher,
    Hyprland-Desktop-Portal,
    Hyprland-Waybar,
    flakeProgramsSqlite,
    nil,
    #gets latest version of nil
    ...
  } @ inputs: let
    system = "x86_64-linux";

    #nixpkgs.config.allowUnfree = true;
    user = "ryan";
    overlays = [
      #inputs.anyrun.overlay
      (_: super: let pkgs = fenix.inputs.nixpkgs.legacyPackages.${super.system}; in fenix.overlays.default pkgs pkgs)
      #neovim-nightly-overlay.overlay
      (self: super: {
        discord = super.discord.override {withOpenASAR = true;};
      })
    ];
  in {
    formatter.x86_64-linux = alejandra.defaultPackage.${system};
    nixosConfigurations = import ./hosts {
      inherit (nixpkgs) lib;
      inherit inputs nixpkgs hyprland nixos-hardware user self sops-nix;
      specialArgs.inputs = inputs;
    }; # Imports ./hosts/default.nix

    homeConfigurations = {
      HmInputs = overlays system alejandra neovim-nightly-overlay;
      nixpkgs.overlays = overlays;

      Nebula = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        modules = [
          hyprland.homeManagerModules.default
          ./home/home.nix
        ];

        extraSpecialArgs = {
          inherit nix-colors self;
          computer = "Nebula";
          inherit overlays system;
          inherit alejandra neovim-nightly-overlay nil;
        };
      };

      Galaxia = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        modules = [
          hyprland.homeManagerModules.default
          ./home/home.nix
        ];

        extraSpecialArgs = {
          inherit nix-colors;
          computer = "Galaxia";
          inherit overlays system;
          inherit alejandra neovim-nightly-overlay nil;
        };
      };
    };
  };
}
