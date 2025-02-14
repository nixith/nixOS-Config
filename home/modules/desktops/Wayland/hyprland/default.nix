hyprland:
{ config, lib, pkgs, osConfig, ... }:
let

  cfg = config.nixith.hyprland;

  hyprlandPackage = hyprland.packages.${pkgs.system}.hyprland;

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
  #imports = [ ../General/eww ];
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
      description = "if extra nvidia considerations should be used";
    };
  };
  # actually enable hyprland

  # Fix waybar
  config = lib.mkIf cfg.enable {

    nixith.anyrun.enable = true;
    wayland.windowManager.hyprland = {
      package = hyprlandPackage;
      enable = true;
      #TODO: move to nix-based config
      extraConfig = import ./config.nix {
        inherit pkgs;
        inherit (cfg) monitors;
        HyprEnv =
          lib.concatLines [ HyprEnv (lib.optionalString cfg.nvidia NvidiaEnv) ];
      };
      systemd = {
        enable = true;
        enableXdgAutostart = true;
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

    # xdg.configFile."hypr/Assets/tropic_island_night.jpg".source =
    #   ./Assets/tropic_island_night.jpg;

    home.file = {
      scripts = {
        enable = true;
        executable = true;
        recursive = true;
        source = ./scripts;
        target = ".config/hypr/scripts";
      };
    };

    #TODO: hyprcursor
    #TODO: swap over to hyprIDLE
    # services.swayidle = {
    #   enable =
    #     false; # TODO DPMS won't turn on and lock occurs after resume, not before dpms turns off.
    #   events = [
    #     # {
    #     #   event = "after-resume";
    #     #   command = "";
    #     # }
    #     {
    #       event = "lock";
    #       command = "${config.programs.swaylock.package}/bin/swaylock -fF -C ${
    #           config.xdg.configFile."swaylock/config".source
    #         }";
    #     }
    #     {
    #       event = "before-sleep";
    #       command = "${pkgs.systemd}/bin/loginctl lock-session $XDG_SESSION_ID";
    #     }
    #   ];
    #   #brillo -A 20 -u 500000
    #   timeouts = [
    #     (lib.mkIf cfg.autosuspend {
    #       timeout = 300;
    #       command = "${pkgs.systemd}/bin/systemctl suspend";
    #     })
    #     {
    #       timeout = 180;
    #       command =
    #         "${hyprlandPackage}/bin/hyprctl dispatch dpms off && ${pkgs.systemd}/bin/loginctl lock-session $XDG_SESSION_ID";
    #       resumeCommand = "${hyprlandPackage}/bin/hyprctl dispatch dpms on";
    #     }
    #     {
    #       timeout = 120;
    #       command =
    #         "${pkgs.brillo}/bin/brillo -O && ${pkgs.brillo}/bin/brillo -S 20 -u 500000";
    #       resumeCommand = "${pkgs.brillo}/bin/brillo -I -u 500000";
    #     }
    #   ];
    # };

    services = {
      wob = {
        enable = true;
        #settings = {}; #TODO: configure wob
        systemd = true;
      };
      wlsunset = {
        enable = true;
        latitude = "35.65";
        longitude = "-78.83";
      };
      hyprpaper = {
        enable = true;
        settings = {
          ipc = "on";
          splash = false;
          preload = [ "${./Assets/tropic_island_night.jpg}" ];
          wallpaper = [ ",${./Assets/tropic_island_night.jpg}" ];
        };
      };
      hypridle = {
        enable = true;
        settings = {
          general = {
            before_sleep_cmd = "loginctl lock-session";
            after_sleep_cmd = "hyprctl dispatch dpms on";
            ignore_dbus_inhibit = false;
            lock_cmd = "pidof hyprlock || hyprlock";
          };

          listener = [
            {
              timeout = 180;
              on-timeout =
                "${pkgs.brillo}/bin/brillo -O && ${pkgs.brillo}/bin/brillo -S 20 -u 500000";
              on-resume = "${pkgs.brillo}/bin/brillo -I -u 500000";
            }
            (lib.mkIf
              (builtins.isAttrs osConfig.security.pam.services.hyprlock) {
                timeout = 300;
                on-timeout = "loginctl lock-session";
              })
            {
              timeout = 360;
              on-timeout = "hyprctl dispatch dpms off";
              on-resume = "hyprctl dispatch dpms on";
            }
          ];
        };
      };
    };
    programs.hyprlock = {
      enable = builtins.isAttrs osConfig.security.pam.services.hyprlock;
      settings = {
        general = {
          disable_loading_bar = true;
          grace = 300;
          hide_cursor = true;
          no_fade_in = false;
        };

        background = [{
          path = "screenshot";
          blur_passes = 3;
          blur_size = 8;
        }];

        input-field = [{
          size = "200, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(202, 211, 245)";
          inner_color = "rgb(91, 96, 120)";
          outer_color = "rgb(24, 25, 38)";
          outline_thickness = 5;
          # placeholder_text = '\'Password...'\';
          shadow_passes = 2;
        }];
      };
    };
  };
}
