{
  inputs,
  self,
  user,
  hyprland,
  home-manager,
  config,
  pkgs,
  computer,
  ...
}: let
  user = user;

  monitors =
    if computer == "Galaxia"
    then (import ./snippets/DesktopMonitors.nix {})
    else ''
      monitor=,preferred,auto,auto
    '';
  HyprEnv = ''
     env = XDG_CURRENT_DESKTOP,Hyprland
    env = XDG_SESSION_TYPE,wayland
    env = XDG_SESSION_DESKTOP,Hyprland

    env = QT_AUTO_SCREEN_SCALE_FACTOR,1
    env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1

    env = CLUTTER_BACKEND,"wayland"
     env = SDL_VIDEODRIVER,wayland
  '';
in {
  # actually enable hyprland
  imports = [../General/Waybar ../General/Rofi ../General/Dunst];

  # Fix waybar
  programs.waybar.package = pkgs.waybar.overrideAttrs (oldAttrs: {
    postPatch = ''
      # use hyprctl to switch workspaces
      sed -i 's/zext_workspace_handle_v1_activate(workspace_handle_);/const std::string command = "hyprctl dispatch workspace " + name_;\n\tsystem(command.c_str());/g' src/modules/wlr/workspace_manager.cpp
    '';
    mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
  });

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = import ./config.nix {
      inherit pkgs;
      inherit monitors;
      inherit HyprEnv;
    };
    xwayland = {
      enable = true;
      hidpi = true;
    };
    nvidiaPatches =
      if computer == "Galaxia"
      then true
      else false;
    recommendedEnvironment = true;
  };

  home.packages = with pkgs; [
    slurp
    xdg-desktop-portal
    xdg-desktop-portal-wlr
    xdg-desktop-portal-gtk
    xdg-dbus-proxy
    swww
    polkit_gnome
    wl-clipboard
    swaylock-fancy
    swayidle
    brightnessctl
    grim
    sway-contrib.grimshot
  ];

  services.wlsunset = {
    enable = true;
    latitude = "35.65";
    longitude = "-78.83";
  };
  xdg.configFile."hypr/Assets/tropic_island_night.jpg".source =
    ./Assets/tropic_island_night.jpg;

  # Wallpaper
}
