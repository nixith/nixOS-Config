{
  inputs,
  system,
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
    then
      (
        import ./snippets/DesktopMonitors.nix {}
      )
    else ''
      monitor=,preferred,auto,auto
    '';

  nvidiaPatches =
    if computer == "Galaxia"
    then true
    else false;

  hyprlandPackage =
    if computer == "Galaxia"
    then inputs.hyprland.packages.${pkgs.system}.hyprland-nvidia
    else inputs.hyprland.packages.${pkgs.system}.hyprland;

  HyprEnv = ''
    env = XDG_CURRENT_DESKTOP,Hyprland
    env = XDG_SESSION_TYPE,wayland
    env = XDG_SESSION_DESKTOP,Hyprland

    env = QT_AUTO_SCREEN_SCALE_FACTOR,1
    env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1

    env = CLUTTER_BACKEND,"wayland"
    env = SDL_VIDEODRIVER,wayland
    env = NIXOS_OZONE_WL, 1
  '';
in {
  # actually enable hyprland
  imports = [../General/eww ../General/Rofi ../General/anyrun ../General/Dunst];

  # Fix waybar

  wayland.windowManager.hyprland = {
    package = hyprlandPackage;
    enable = true;
    extraConfig = import ./config.nix {
      inherit pkgs;
      inherit monitors;
      inherit HyprEnv;
      inherit computer;
    };
    xwayland = {
      enable = true;
    };
    enableNvidiaPatches = nvidiaPatches;
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
    brightnessctl
    grim
    #anyrun
    sway-contrib.grimshot
  ];

  services.wlsunset = {
    enable = true;
    latitude = "35.65";
    longitude = "-78.83";
  };

  xdg.configFile."hypr/Assets/tropic_island_night.jpg".source = ./Assets/tropic_island_night.jpg;

  home.file = {
    scripts = {
      enable = true;
      executable = true;
      recursive = true;
      source = ./scripts;
      target = ".config/hypr/scripts";
    };
  };

  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
    };
  };

  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock";
      }
      {
        event = "lock";
        command = "lock";
      }
    ];

    timeouts = [
      {
        timeout = 120;
        command = "${pkgs.swaylock}/bin/swaylock -fF";
      }
    ];
  };
}
