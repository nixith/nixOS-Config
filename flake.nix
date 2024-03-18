{
  description = "nixith's nix config";

  nixConfig = {
    # allow building without passing flags on first run
    extra-experimental-features = "nix-command flakes";
    # Add me to trusted users
    trusted-users = ["root" "@wheel" "ryan"];
    builders-use-substitutes = true;

    # Grab binaries faster from sources
    substituters = [
      "https://cache.nixos.org/"
      "https://cache.garnix.io"
      "https://hyprland.cachix.org"
      "https://nix-community.cachix.org"
      "https://nix-gaming.cachix.org"
      "https://anyrun.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g=" #Me, Prism Launcher,
    ];
    http-connections = 0; #No limit on number of connections

    # nix store optimizations
    auto-optimise-store = true;
    allowUnfree = true;
    accept-flake-config = true;
    allow-import-from-derivation = true;
  };

  inputs = {
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fish-z = {
      url = "github:jethrokuan/z";
      flake = false;
    };
    fish-fzf = {
      url = "github:PatrickF1/fzf.fish";
      flake = false;
    };

    spicetify-nix.url = "github:the-argus/spicetify-nix";
    catppuccin-spicetify = {
      url = "github:catppuccin/spicetify";
      flake = false;
    };

    nix-gaming.url = "github:fufexan/nix-gaming";
    fenix = {
      url = "github:nix-community/fenix";
    };

    flakeProgramsSqlite = {
      url = "github:wamserma/flake-programs-sqlite";
    };

    anyrun.url = "github:Kirottu/anyrun";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    sops-nix.url = "github:Mic92/sops-nix";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    prismlauncher = {
      url = "github:prismlauncher/prismlauncher";
      #inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
    };

    #Hyprland-Desktop-Portal = {
    #  url = "github:hyprwm/xdg-desktop-portal-hyprland";
    #};

    #Hyprland-Waybar = {
    #  url = "github:r-clifford/Waybar-Hyprland";
    #  #inputs.nixpkgs.follows = "nixpkgs";
    #};

    nixos-hardware = {url = "github:NixOS/nixos-hardware/master";};

    nix-colors = {url = "github:misterio77/nix-colors";};

    nixd = {url = "github:nix-community/nixd";};

    alejandra = {
      url = "github:kamadorueda/alejandra";
      #inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    fenix,
    anyrun,
    nixpkgs,
    sops-nix,
    hyprland,
    home-manager,
    nixos-hardware,
    nixos-generators,
    nix-colors,
    neovim-nightly-overlay,
    alejandra,
    nix-gaming,
    prismlauncher,
    flakeProgramsSqlite,
    niri,
    ...
  } @ inputs: let
    system = "x86_64-linux";

    forAllSystems = function:
      nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
      ] (system: function nixpkgs.legacyPackages.${system});

    #nixpkgs.config.allowUnfree = true;
    user = "ryan";
    overlays = [
      (_: super: let pkgs = fenix.inputs.nixpkgs.legacyPackages.${super.system}; in fenix.overlays.default pkgs pkgs)
      #neovim-nightly-overlay.overlay
      (final: prev: {
        discord = prev.discord.override {withOpenASAR = true;};
      })
      (final: prev: {
        spotifyd = prev.spotifyd.override {
          withKeyring = true;
          withPulseAudio = true;
          withMpris = true;
        };
      })
    ];
  in {
    formatter.x86_64-linux = alejandra.defaultPackage.${system};
    nixosConfigurations = import ./hosts {
      inherit (nixpkgs) lib;
      inherit inputs nixpkgs hyprland nixos-hardware user self sops-nix niri;
      specialArgs.inputs = inputs;
    }; # Imports ./hosts/default.nix

    homeConfigurations = let
      commonModules = [
        niri.homeModules.config
        ./home/home.nix
        anyrun.homeManagerModules.default
        inputs.spicetify-nix.homeManagerModules.default
        sops-nix.homeManagerModules.sops
      ];
    in {
      HmInputs = overlays system alejandra neovim-nightly-overlay;
      nixpkgs.overlays = overlays;
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;

      Nebula = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        modules = commonModules;

        extraSpecialArgs = {
          inherit nix-colors;
          computer = "Nebula";
          inherit overlays system inputs;
          inherit alejandra neovim-nightly-overlay hyprland niri;
        };
      };

      Galaxia = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        modules = commonModules;

        extraSpecialArgs = {
          inherit nix-colors;
          computer = "Galaxia";
          inherit overlays system inputs;
          inherit alejandra neovim-nightly-overlay hyprland;
        };
      };
    };

    packages = forAllSystems (pkgs: {
      pmd = pkgs.callPackage ./packages/pmd.nix {};
      iso = nixos-generators.nixosGenerate {
        system = pkgs.system;
        modules = [
          ./isoBuilder/iso.nix
          (nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")

          # Provide an initial copy of the NixOS channel so that the user
          # doesn't need to run "nix-channel --update" first.
          (nixpkgs + "/nixos/modules/installer/cd-dvd/channel.nix")
        ];
        format = "install-iso";
      };
    });
  };
}
