# Edit this configuration file to define what should be installed oncon
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, inputs, pkgs, ... }:
let
in {
  # NTFS Support
  boot.supportedFilesystems = [ "ntfs" ];

  imports = [ ];

  time.timeZone = "America/New_York"; # Select internationalisation properties.
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

  services = {
    resolved = {
      # works better with tailscale
      enable = true;

      extraConfig = ''
        ReadEtcHosts=yes
      '';
      fallbackDns = [ "1.1.1.1" "1.0.0.1" "9.9.9.9" ];
    };

    fwupd.enable = true;
  };

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

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep 5 --keep-since 3d";
  };

  nix = {
    settings = {
      substituters =
        [ "https://cache.nixos.org/" "https://nix-community.cachix.org" ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];

      auto-optimise-store = true; # Optimise syslinks
      allow-import-from-derivation = true;
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "@wheel" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 5d";
    };
  };
}
