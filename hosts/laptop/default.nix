{ config, pkgs, user, ... }:

{
  imports =
    [ (import ./hardware-configuration.nix) ] ++
    [ (import ../../modules/desktop/hyprland/default.nix) ] ++
    [ (import ../../modules/fonts/fonts.nix) ] ++
    (import ../../modules/hardware) ++
    (import ../../modules/virtualisation);

  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;

    loader.grub = {
  enable = true;
  device =  "nodev" ;
  useOSProber = true; # enables dual boot;
    };

  };

