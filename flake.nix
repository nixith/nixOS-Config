{
  description = "nixith's nix config";
  nixConfig = {
    lazy-trees = true;
    # allow building without passing flags on first run
    extra-experimental-features = "nix-command flakes";
    # Add me to trusted users
    trusted-users = [
      "root"
      "@wheel"
      "alice"
    ];
    builders-use-substitutes = true;

    # Grab binaries faster from sources
    substituters = [
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
      "https://anyrun.cachix.org"
      "https://cuda-maintainers.cachix.org"
      "https://niri.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
    ];
    http-connections = 0; # No limit on number of connections

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
    niri = {
      url = "github:sodiboo/niri-flake";
    };
    stylix.url = "github:danth/stylix";
    nixivim = {
      url = "github:nixith/nixivim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";

    lix-modules = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flakeProgramsSqlite = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    sops-nix.url = "github:Mic92/sops-nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };

    nixos-facter-modules.url = "github:nix-community/nixos-facter-modules";

    nixd = {
      url = "github:nix-community/nixd";
    };

  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixos-hardware,
      niri,
      nixos-generators,
      flakeProgramsSqlite,
      stylix,
      lix-modules,
      # determinate,
      ...
    }@inputs:
    let
      system = "x86_64-linux";

      forAllSystems =
        function:
        nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" ] (
          system:
          function (
            import nixpkgs {
              inherit system;
              config.allowUnfree = true;
            }
          )
        );

      #nixpkgs.config.allowUnfree = true;
      user = "alice";

    in
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
      nixosConfigurations = import ./hosts {
        inherit (nixpkgs) lib;
        inherit
          inputs
          nixpkgs
          nixos-hardware
          user
          self
          home-manager
          niri
          flakeProgramsSqlite
          ;
        specialArgs.inputs = inputs;
      };

      # Imports ./hosts/default.nix
      homeManagerModules = {
        modules = import ./home/modules/modules.nix { inherit inputs; };
        default = self.homeManagerModules.modules;
        extraSpecialArgs = { inherit inputs; };
      };
      homeConfigurations = {
        laptop = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = "x86_64-linux"; };
          modules = [ ./hosts/laptop/home.nix ];
          extraSpecialArgs = { inherit self user; };
        };
      };

      packages = forAllSystems (pkgs: {
        my-pmd = pkgs.callPackage ./packages/pmd/pmd.nix { };
        ollama-cuda = pkgs.callPackage ./packages/ollama-cuda/ollama-cuda.nix { };
        iso = nixos-generators.nixosGenerate {
          inherit system;
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
      # overlays = forAllSystems (pkgs: {
      #   default = final: prev: {
      #     inherit system;
      #     # final is top level results, let the new stuff exist on top
      #     #
      #   };
      # });
    };
}
