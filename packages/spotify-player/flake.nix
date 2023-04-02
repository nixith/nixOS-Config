{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    naersk.url = "github:nix-community/naersk";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    spotify-player = {
      url = "github:aome510/spotify-player";
      flake = false;
    };
  };

  outputs = { self, flake-utils, naersk, nixpkgs, spotify-player }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = (import nixpkgs) {
          inherit system;
        };

        naersk' = pkgs.callPackage naersk { };

      in
      rec {
        # For `nix build` & `nix run`:
        defaultPackage = naersk'.buildPackage {
          src = spotify-player;
          nativeBuildInputs = with pkgs; [
            dbus
            pkg-config
          ];
          buildInputs = with pkgs;
            [
              openssl
              pkg-config
              alsa-lib
              dbus
            ];
        };

        # For `nix develop`:
        devShell = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [ rustc cargo ];
        };
      }
    );
}
