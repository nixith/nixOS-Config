{ config, lib, pkgs, user, inputs, nix-colors, ... }:
{

  nixpkgs.config.allowUnfree = true;

  #cachic  

  #nix.settings = {
  #  substituters = [ "https://hyprland.cachix.org" ];
  #  trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  #};


  home.stateVersion = "22.11";
  programs.home-manager.enable = true; #enable home manager and allow it to manage itself

  systemd.user.startServices = "sd-switch"; # reload systemd units on config reload


  home = {
    username = "ryan";
    homeDirectory = "/home/ryan";

    packages = with pkgs; [
      ntfs3g
      gh
      bitwarden
      bitwarden-cli
      git
      zellij
    ];
    sessionVariables = {
      EDITOR = "helix";
      SHELL = "fish";
    };
  };
  # User Configuration
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };
  imports = [
    ./modules/desktops/Wayland/hyprland/default.nix
    ./modules/desktops/Wallpapers
    ./modules/gtk/catppuccin.nix
    ./modules/CLI/Tools.nix
    ./modules/CLI/btop
    ./modules/shells/Fish
    ./modules/shells/Starship
    ./modules/Gui
    ./modules/Gui/xournalpp
    ./modules/editors/helix
    ./modules/Terminals/Wezterm

    nix-colors.homeManagerModule

  ];


  fonts.fontconfig.enable = true;

  colorScheme = nix-colors.colorSchemes.catppuccin;
}

