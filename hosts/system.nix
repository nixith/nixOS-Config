# Edit this configuration file to define what should be installed oncon
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let

in {

  # NTFS Support
  boot.supportedFilesystems = [ "ntfs" ];

  imports = [ ];

  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  networking.networkmanager.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # To manage the actual user configuration
    nix
    thermald
    auto-cpufreq
    cachix
  ];

  # Systemd packages to enable (Enable when out of VM)
  services = {
    auto-cpufreq.enable = true;
    thermald.enable = true;
  };

  nix = {
    settings.auto-optimise-store = true; # Optimise syslinks
    settings.experimental-features = [ "nix-command" "flakes" ];
    settings.trusted-users = ["root" "@wheel"];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 5d";
    };
  };
}

