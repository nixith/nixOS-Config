{
  pkgs,
  nix-colors,
  computer,
  overlays,
  ...
}: let
  windowManager = ./modules/desktops/Wayland/hyprland/default.nix;
  Nvidia =
    if computer == "Galaxia"
    then true
    else false;
  username = "ryan";
  homeDirectory = "/home/${username}";
in {
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = overlays;
  #cachic

  programs.home-manager.enable = true; # enable home manager and allow it to manage itself

  systemd.user.startServices = "sd-switch"; # reload systemd units on config reload

  home = {
    stateVersion = "22.11";

    sessionVariables = {
      EDITOR = "nvim";
      SHELL = "fish";
    };

    inherit username homeDirectory;
    packages = with pkgs; [
      thunderbirdPackages.thunderbird-115
      ntfs3g
      pulseaudio
      libsForQt5.xp-pen-g430-driver
      gh
      #bitwarden #Marked as insecure due to nodeJS
      bitwarden-cli
      git
      zellij
      python3
      webcord-vencord
      gnome.gnome-disk-utility
      partition-manager
      gum
      glfw-wayland
      hyfetch
      obsidian
    ];
  };
  # User Configuration

  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
    };

    systemDirs = {
      data = ["${homeDirectory}/.local/share"];
    };
  };

  imports = [
    ./modules/services/syncthing/default.nix
    ./modules/desktops/Wallpapers
    ./modules/gtk/adw-gtk3.nix
    ./modules/CLI/Tools.nix
    ./modules/CLI/btop
    ./modules/shells/Fish
    ./modules/shells/nushell
    ./modules/shells/shellApps/Starship
    #./modules/shells/shellApps/carapace.nix
    ./modules/shells/shellApps/zoxide.nix
    ./modules/shells/shellApps/direnv.nix
    ./modules/Gui/spotify
    # Gui Tools
    ./modules/Gui
    ./modules/Gui/xournalpp
    ./modules/Gui/newsboat
    ./modules/Gui/firefox
    ./modules/Gui/zathura/default.nix
    ./modules/editors/helix
    ./modules/Gui/QT/default.nix
    ./modules/editors/vscode
    ./modules/editors/neovim
    ./modules/Terminals/Wezterm
    ./modules/Terminals/Rio
    ./modules/Terminals/Kitty
    ./nix/secrets.nix
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

  colorScheme = nix-colors.colorSchemes.catppuccin-mocha;
}
