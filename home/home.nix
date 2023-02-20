{ config
, lib
, pkgs
, user
, inputs
, nix-colors
, systemType
, nix-doom-emacs
, ...
}:

let nvidia = builtins.hasAttr "nvidia" config.hardware;
in
{
  nixpkgs.config.allowUnfree = true;
  #cachic  

  #nix.settings = {
  #  substituters = [ "https://hyprland.cachix.org" ];
  #  trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  #};

  home.stateVersion = "22.11";
  programs.home-manager.enable =
    true; # enable home manager and allow it to manage itself

  systemd.user.startServices =
    "sd-switch"; # reload systemd units on config reload

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
      xfce.thunar
      gnome.nautilus
      gnome.gnome-disk-utility
      partition-manager
      zig
      glfw-wayland
      xdg-desktop-portal-gtk
    ];
  };
  home.sessionVariables = {
    EDITOR = "nvim";
    SHELL = "fish";

    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";

    QT_AUTO_SCREEN_SCALE_FACTOR = 1;
    QT_QAYLAND_DISABLE_WINDOWDECORATION = 1;
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };
  # User Configuration
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  imports = [
    ./modules/services/syncthing/default.nix
    ./modules/desktops/Wayland/hyprland/default.nix
    ./modules/desktops/Wallpapers
    ./modules/gtk/catppuccin.nix
    ./modules/CLI/Tools.nix
    ./modules/CLI/btop
    ./modules/shells/Fish
    ./modules/shells/Starship
    ./modules/Gui
    ./modules/Gui/xournalpp
    ./modules/Gui/newsboat
    ./modules/editors/helix
    ./modules/editors/emacs
    ./modules/editors/neovim
    #./modules/Terminals/Wezterm
    ./modules/Terminals/Kitty
    #./modules/languages/python
    #./modules/Meta/cachix.nix
    nix-colors.homeManagerModule

  ] ++ [ ./NvidiaHome.nix ];

  #caches.cachix = [ "nix-community" "hyprland" ];

  fonts.fontconfig.enable = true;

  colorScheme = nix-colors.colorSchemes.catppuccin;
}

