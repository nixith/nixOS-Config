{
  config,
  lib,
  pkgs,
  user,
  inputs,
  nix-colors,
  systemType,
  nix-doom-emacs,
  spicetify-nix,
  computer,
  overlays,
  neovim-nightly-overlay,
  alejandra,
  ...
}: let
  windowManager = ./modules/desktops/Wayland/hyprland/default.nix;
  Nvidia =
    if computer == "Galaxia"
    then true
    else false;
in {
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = overlays;
  #cachic

  #
  home.stateVersion = "22.11";
  programs.home-manager.enable =
    true; # enable home manager and allow it to manage itself

  systemd.user.startServices = "sd-switch"; # reload systemd units on config reload

  home = {
    username = "ryan";
    homeDirectory = "/home/ryan";

    packages = with pkgs; [
      ntfs3g
      pulseaudio
      libsForQt5.xp-pen-g430-driver
      gh
      bitwarden
      bitwarden-cli
      git
      zellij
      python3
      discord
      xfce.thunar
      gnome.nautilus
      gnome.gnome-disk-utility
      partition-manager
      zig
      glfw-wayland
      hyfetch
      audacity
      (pkgs.nerdfonts.override {fonts = ["FiraCode" "DroidSansMono"];})
    ];
  };
  home.sessionVariables = {
    EDITOR = "nvim";
    SHELL = "fish";
  };
  # User Configuration
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  imports = [
    ./modules/services/syncthing/default.nix
    ./modules/desktops/Wallpapers
    ./modules/gtk/catppuccin.nix
    ./modules/CLI/Tools.nix
    ./modules/CLI/btop
    ./modules/shells/Fish
    #./modules/shells/nushell
    ./modules/shells/Starship
    # ./modules/Gui/spotify

    # Gui Tools
    ./modules/Gui
    ./modules/Gui/xournalpp
    ./modules/Gui/newsboat
    ./modules/Gui/zathura/default.nix
    ./modules/editors/helix
    ./modules/Gui/QT/default.nix
    #./modules/editors/emacs
    ./modules/editors/neovim
    ./modules/Terminals/Wezterm
    ./modules/Terminals/Kitty
    #./modules/languages/python
    #./modules/Meta/cachix.nix
    nix-colors.homeManagerModule
    (
      if Nvidia
      then ./NvidiaHome.nix
      else windowManager
    )
  ];
  #caches.cachix = [ "nix-community" "hyprland" ];
  fonts.fontconfig.enable = true;

  programs.ncspot = {
    enable = true;
  };

  colorScheme = nix-colors.colorSchemes.catppuccin-mocha;
}
