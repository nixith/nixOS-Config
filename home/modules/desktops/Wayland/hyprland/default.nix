{ inputs, config, lib, pkgs, ... }:
let
  cfg = config.nixith.hyprland;

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
  NvidiaEnv = ''
      env = LIBVA_DRIVER_NAME,nvidia
      env = XDG_SESSION_TYPE,wayland
      env = GBM_BACKEND,nvidia-drm
      env = __GLX_VENDOR_LIBRARY_NAME,nvidia
'';
in {
  imports = [ ../General/eww ../General/anyrun ../General/Dunst ];
  options.nixith.hyprland = {
    enable = lib.mkEnableOption "enable hyprland";
    monitors = lib.mkOption {
      type = lib.types.lines;
      default = ''
        monitor=,preferred,auto,auto
      '';
      example = lib.literalExpression ''
        monitor=HDMI-A-1,1920x1080@60,0x0,1,vrr,2
        monitor=DP-1,1920x1080@60,1920x0,1,vrr,2
        monitor=DP-2,1920x1080@60,3840x0,1,vrr,2
        monitor=DP-2,transform,1
        #monitor=DP-1,transform,1
      '';
      description = ''
        monitor configuration for hyprland
      '';
    };
    autosuspend = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "if the computer should suspend after a period of activity";
    };
    nvidia = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "if extra nvidia considerations should be used"};
  };
  # actually enable hyprland

  # Fix waybar
  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      package = hyprlandPackage;
      enable = true;
      extraConfig = import ./config.nix {
        inherit pkgs;
        inherit (cfg) monitors;
        HyprEnv = lib.concatLines [ HyprEnv (lib.strings.optionals cfg.nvidia nvididaEnv )];
      };
      systemd = {
        enable = true;
        variables = [ "--all" ];
      };
      xwayland = { enable = true; };
    };
    # secret management

    home.packages = with pkgs; [
      slurp
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

    xdg.configFile."hypr/Assets/tropic_island_night.jpg".source =
      ./Assets/tropic_island_night.jpg;

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

    #TODO: hyprcursor
    #TODO: swap over to hyprIDLE
    services.swayidle = {
      enable =
        false; # TODO DPMS won't turn on and lock occurs after resume, not before dpms turns off.
      events = [
        # {
        #   event = "after-resume";
        #   command = "";
        # }
        {
          event = "lock";
          command = "${config.programs.swaylock.package}/bin/swaylock -fF -C ${
              config.xdg.configFile."swaylock/config".source
            }";
        }
        {
          event = "before-sleep";
          command = "${pkgs.systemd}/bin/loginctl lock-session $XDG_SESSION_ID";
        }
      ];
      #brillo -A 20 -u 500000
      timeouts = [
        (lib.mkIf cfg.autosuspend {
          timeout = 300;
          command = "${pkgs.systemd}/bin/systemctl suspend";
        })
        {
          timeout = 180;
          command =
            "${hyprlandPackage}/bin/hyprctl dispatch dpms off && ${pkgs.systemd}/bin/loginctl lock-session $XDG_SESSION_ID";
          resumeCommand = "${hyprlandPackage}/bin/hyprctl dispatch dpms on";
        }
        {
          timeout = 120;
          command =
            "${pkgs.brillo}/bin/brillo -O && ${pkgs.brillo}/bin/brillo -S 20 -u 500000";
          resumeCommand = "${pkgs.brillo}/bin/brillo -I -u 500000";
        }
      ];
    };

    services.wob = {
      enable = true;
      #settings = {}; #TODO: configure wob
      systemd = true;
    };
  };
}
