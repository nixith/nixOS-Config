{
  description = "A useful config";

  nixConfig = {
    # allow building without passing flags on first run
    extra-experimental-features = "nix-command flakes";

    # Grab binaries faster from sources
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    http-connections = 0; #No limit on number of connections

    # nix store optimizations
    auto-optimise-store = true;

  };


  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    sops-nix.url = "github:Mic92/sops-nix";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";



    home-manager = {
      url = "github:nix-community/home-manager";
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

    nixos-hardware = { url = "github:NixOS/nixos-hardware/master"; };

    nix-colors = { url = "github:misterio77/nix-colors"; };
    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
    #emacs-overlay = {
    #  url = "github:nix-community/emacs-overlay";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};


    nil = { url = "github:oxalica/nil"; };
  };

  outputs =
    { self
    , nixpkgs
    , sops-nix
    , hyprland
    , home-manager
    , nixos-hardware
    , nix-colors
    , nix-doom-emacs
    , neovim-nightly-overlay
    , Hyprland-Desktop-Portal
    , Hyprland-Waybar #Too remove later
    , nil #gets latest version of nil
    , ...
    }@inputs:

    let

      system = "x86_64-linux";

      #nixpkgs.config.allowUnfree = true;
      pkgs = nixpkgs.legacyPackages.${system};
      user = "ryan";
      overlays = [ inputs.neovim-nightly-overlay.overlay ];
    in
    {
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
          };

        };
      };

    };
}

