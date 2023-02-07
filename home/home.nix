{ config, lib, pkgs, user, inputs, nix-colors, systemType, ... }:


let
  nvidia = builtins.hasAttr "nvidia" config.hardware;
in
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
    ];
  };
  home.sessionVariables = {
    EDITOR = "helix";
    SHELL = "fish";

    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";

    QT_AUTO_SCREEN_SCALE_FACTOR = 1;
    QT_QPA_PLATFORM = "wayland,xcb";
    QT_QAYLAND_DISABLE_WINDOWDECORATION = 1;
    QT_QPA_PLATFORMTHEME = "qt5ct";

    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = 1;
    __GL_VRR_ALLOWED = 0;
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
    ./modules/editors/neovim
    ./modules/Terminals/Wezterm

    nix-colors.homeManagerModule

  ] ++ [ ./NvidiaHome.nix ];


  fonts.fontconfig.enable = true;

  colorScheme = nix-colors.colorSchemes.catppuccin;
}

