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

  hyprlandPackage = inputs.hyprland.packages.${pkgs.system}.hyprland;

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
  imports = [../General/eww ../General/anyrun ../General/Dunst];

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
  };
  # secret management
  services.gnome-keyring.enable = true;

  home.packages = with pkgs; [
    slurp
    xdg-desktop-portal
    xdg-desktop-portal-wlr
    xdg-desktop-portal-gtk
    xdg-dbus-proxy
    swww
    polkit_gnome
    wl-clipboard
    clipboard-jh
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
      color = "1e1e2e";
      indicator-caps-lock = true;
      font = "Lilex Nerd Font Regular";
      clock = true;
    };
  };

  services.swayidle = {
    enable = false; #TODO DPMS won't turn on and lock occurs after resume, not before dpms turns off.
    events = [
      # {
      #   event = "after-resume";
      #   command = "";
      # }
      {
        event = "lock";
        command = "${config.programs.swaylock.package}/bin/swaylock -fF -C ${config.xdg.configFile."swaylock/config".source}";
      }
      {
        event = "before-sleep";
        command = "${pkgs.systemd}/bin/loginctl lock-session $XDG_SESSION_ID";
      }
    ];
    #brillo -A 20 -u 500000
    timeouts = [
      {
        timeout = 300;
        command =
          if computer == "Nebula" #only suspend on laptop
          then "${pkgs.systemd}/bin/systemctl suspend"
          else "";
      }
      {
        timeout = 180;
        command = "${hyprlandPackage}/bin/hyprctl dispatch dpms off && ${pkgs.systemd}/bin/loginctl lock-session $XDG_SESSION_ID";
        resumeCommand = "${hyprlandPackage}/bin/hyprctl dispatch dpms on";
      }
      {
        timeout = 120;
        command = "${pkgs.brillo}/bin/brillo -O && ${pkgs.brillo}/bin/brillo -S 20 -u 500000";
        resumeCommand = "${pkgs.brillo}/bin/brillo -I -u 500000";
      }
    ];
  };
}
