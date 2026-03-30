# system.nix
let
  pins = import ../../npins;
  nixpkgs = pins.nixpkgs;
in
import "${nixpkgs}/nixos" {
  # Build NixOS using an external configuration.nix file,
  # or directly set your options here
  configuration = ./config.nix;
}
