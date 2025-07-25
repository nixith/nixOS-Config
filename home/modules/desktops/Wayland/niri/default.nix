# niri:
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.nixith.niri;
in
{

  imports = [ ../General/mako ];

  options.nixith.niri = {
    enable = lib.mkEnableOption "enable niri";
    config = lib.mkOption {
      type = lib.types.str;
      description = "niri config (make into nix config eventually)";
    };
  };

  config = lib.mkIf cfg.enable {
    # osConfig = {
    #   xdg = {
    #     autostart.enable = true;
    #     menus.enable = true;
    #     mime.enable = true;
    #     icons.enable = true;
    #   };
    #   security.pam.services.swaylock = { };
    # };
    nixith.kanshi.enable = true;
    nixith.waybar.enable = true;
    nixith.fuzzel.enable = true;
    services.gnome-keyring = {
      enable = true;
    };
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
        gnome-keyring
      ];
    };
    services.kanshi.systemdTarget = "niri.service";
    home.packages = with pkgs; [
      goofcord
      easyeffects
      wl-clipboard-rs
      satty
      xwayland-satellite
      brillo
      playerctl
    ];

    programs.niri.settings = {
      prefer-no-csd = true;
      environment = {
        QT_QPA_PLATFORM = "wayland";
        DISPLAY = ":0";
        NIXOS_OZONE_WL = "1";
      };
      input = {
        #keyboard.repeat-rate = 10;
        touchpad = {
          click-method = "clickfinger";
          dwt = true;
          scroll-method = "two-finger";
          tap-button-map = "left-right-middle";

        };
        warp-mouse-to-focus = true;
        focus-follows-mouse = {
          enable = true;
          max-scroll-amount = "0%";
        };
        workspace-auto-back-and-forth = true;
      };
      outputs = {
        "*" = {
          background-color = "1e1e2e";
        };
      };

      cursor = {
        size = 16;
      };
      binds = {
        # Volume
        "XF86AudioRaiseVolume" = {
          action.spawn = [
            "wpctl"
            "set-volume"
            "@DEFAULT_AUDIO_SINK@"
            "0.1+"
            "-l"
            "1.0"
          ];
          repeat = true;
          allow-when-locked = true;
          cooldown-ms = 50;
        };
        "XF86AudioLowerVolume" = {
          action.spawn = [
            "wpctl"
            "set-volume"
            "@DEFAULT_AUDIO_SINK@"
            "0.1-"
            "-l"
            "1.0"
          ];
          repeat = true;
          allow-when-locked = true;
          cooldown-ms = 50;
        };
        "XF86AudioMute" = {
          action.spawn = [
            "wpctl"
            "set-mute"
            "@DEFAULT_AUDIO_SINK@"
            "toggle"
          ];
          allow-when-locked = true;
        };

        # Media Controls
        "XF86AudioMedia" = {
          action.spawn = [
            "playerctl"
            "play-pause"
          ];
          allow-when-locked = true;
        };

        "XF86AudioPlay" = {
          action.spawn = [
            "playerctl"
            "play-pause"
          ];
          allow-when-locked = true;
        };

        "XF86AudioNext" = {
          action.spawn = [
            "playerctl"
            "next"
          ];
          allow-when-locked = true;
        };

        "XF86AudioPrev" = {
          action.spawn = [
            "playerctl"
            "prev"
          ];
          allow-when-locked = true;
        };

        # brightness
        "XF86MonBrightnessUp" = {
          action.spawn = [
            "brillo"
            "-U"
            "5"
          ];
          repeat = true;
          cooldown-ms = 50;
        };
        "XF86MonBrightnessDown" = {
          action.spawn = [
            "brillo"
            "-A"
            "5"
          ];
          repeat = true;
          cooldown-ms = 50;
        };

        "Mod+Q" = {
          action.close-window = { };
        };
        "Mod+H" = {
          action.focus-column-or-monitor-left = { };
        };
        "Mod+J" = {
          action.focus-window-or-monitor-down = { };
        };
        "Mod+K" = {
          action.focus-window-or-monitor-up = { };
        };
        "Mod+L" = {
          action.focus-column-or-monitor-right = { };
        };
        # "Mod+Shift+W" = {
        #   action.toggle-column-tabbed-display = { };
        # };
        "Mod+V" = {
          action.toggle-window-floating = { };
        };
        "Mod+Shift+V" = {
          action.switch-focus-between-floating-and-tiling = { };
        };
        # "Mod+T" = { action.toggle-column-tabbed-display = { }; };

        "Mod+Ctrl+H" = {
          action.move-column-left-or-to-monitor-left = { };
        };
        "Mod+Ctrl+J" = {
          action.move-window-down-or-to-workspace-down = { };
        };
        "Mod+Ctrl+K" = {
          action.move-window-up-or-to-workspace-up = { };
        };
        "Mod+Ctrl+L" = {
          action.move-column-right-or-to-monitor-right = { };
        };

        # "Mod+O" = {
        #   action.toggle-overview = { };
        #   repeat = false;
        # };

        "Mod+Home" = {
          action.focus-column-first = { };
        };
        "Mod+End" = {
          action.focus-column-last = { };
        };
        "Mod+Ctrl+Home" = {
          action.move-column-to-first = { };
        };
        "Mod+Ctrl+End" = {
          action.move-column-to-last = { };
        };

        "Mod+Shift+Left" = {
          action.focus-monitor-left = { };
        };
        "Mod+Shift+Down" = {
          action.focus-monitor-down = { };
        };
        "Mod+Shift+Up" = {
          action.focus-monitor-up = { };
        };
        "Mod+Shift+Right" = {
          action.focus-monitor-right = { };
        };
        "Mod+Shift+H" = {
          action.focus-monitor-left = { };
        };
        "Mod+Shift+J" = {
          action.focus-monitor-down = { };
        };
        "Mod+Shift+K" = {
          action.focus-monitor-up = { };
        };
        "Mod+Shift+L" = {
          action.focus-monitor-right = { };
        };

        "Mod+Shift+Ctrl+Left" = {
          action.move-column-to-monitor-left = { };
        };
        "Mod+Shift+Ctrl+Down" = {
          action.move-column-to-monitor-down = { };
        };
        "Mod+Shift+Ctrl+Up" = {
          action.move-column-to-monitor-up = { };
        };
        "Mod+Shift+Ctrl+Right" = {
          action.move-column-to-monitor-right = { };
        };
        "Mod+Shift+Ctrl+H" = {
          action.move-column-to-monitor-left = { };
        };
        "Mod+Shift+Ctrl+J" = {
          action.move-column-to-monitor-down = { };
        };
        "Mod+Shift+Ctrl+K" = {
          action.move-column-to-monitor-up = { };
        };
        "Mod+Shift+Ctrl+L" = {
          action.move-column-to-monitor-right = { };
        };

        # // Alternatively, there are commands to move just a single window:
        # // Mod+Shift+Ctrl+Left  { move-window-to-monitor-left; }
        # // ...
        #
        # // And you can also move a whole workspace to another monitor:
        # // Mod+Shift+Ctrl+Left  { move-workspace-to-monitor-left; }
        # // ...

        "Mod+Page_Down" = {
          action.focus-workspace-down = { };
        };
        "Mod+Page_Up" = {
          action.focus-workspace-up = { };
        };
        "Mod+U" = {
          action.focus-workspace-down = { };
        };
        "Mod+I" = {
          action.focus-workspace-up = { };
        };
        "Mod+Ctrl+Page_Down" = {
          action.move-column-to-workspace-down = { };
        };
        "Mod+Ctrl+Page_Up" = {
          action.move-column-to-workspace-up = { };
        };
        "Mod+Ctrl+U" = {
          action.move-column-to-workspace-down = { };
        };
        "Mod+Ctrl+I" = {
          action.move-column-to-workspace-up = { };
        };

        # // Alternatively, there are commands to move just a single window:
        # // Mod+Ctrl+Page_Down { move-window-to-workspace-down; }
        # // ...

        "Mod+Shift+Page_Down" = {
          action.move-workspace-down = { };
        };
        "Mod+Shift+Page_Up" = {
          action.move-workspace-up = { };
        };
        "Mod+Shift+U" = {
          action.move-workspace-down = { };
        };
        "Mod+Shift+I" = {
          action.move-workspace-up = { };
        };

        # // You can bind mouse wheel scroll ticks using the following syntax.
        # // These binds will change direction based on the natural-scroll setting.
        # //
        # // To avoid scrolling through workspaces really fast, you can use
        # // the cooldown-ms property. The bind will be rate-limited to this value.
        # // You can set a cooldown on any bind, but it's most useful for the wheel.
        "Mod+WheelScrollDown" = {
          cooldown-ms = 150;
          action.focus-workspace-down = { };
        };
        "Mod+WheelScrollUp" = {
          cooldown-ms = 150;
          action.focus-workspace-up = { };
        };
        "Mod+Ctrl+WheelScrollDown" = {
          cooldown-ms = 150;
          action.move-column-to-workspace-down = { };
        };
        "Mod+Ctrl+WheelScrollUp" = {
          cooldown-ms = 150;
          action.move-column-to-workspace-up = { };
        };

        "Mod+WheelScrollRight" = {
          action.focus-column-right = { };
        };
        "Mod+WheelScrollLeft" = {
          action.focus-column-left = { };
        };
        "Mod+Ctrl+WheelScrollRight" = {
          action.move-column-right = { };
        };
        "Mod+Ctrl+WheelScrollLeft" = {
          action.move-column-left = { };
        };

        # // Usually scrolling up and down with Shift in applications results in
        # // horizontal scrolling; these binds replicate that.
        "Mod+Shift+WheelScrollDown" = {
          action.focus-column-right = { };
        };
        "Mod+Shift+WheelScrollUp" = {
          action.focus-column-left = { };
        };
        "Mod+Ctrl+Shift+WheelScrollDown" = {
          action.move-column-right = { };
        };
        "Mod+Ctrl+Shift+WheelScrollUp" = {
          action.move-column-left = { };
        };

        # // Similarly, you can bind touchpad scroll "ticks".
        # // Touchpad scrolling is continuous, so for these binds it is split into
        # // discrete intervals.
        # // These binds are also affected by touchpad's natural-scroll, so these
        # // example binds are "inverted", since we have natural-scroll enabled for
        # // touchpads by default.
        # // Mod+TouchpadScrollDown { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02+"; }
        # // Mod+TouchpadScrollUp   { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02-"; }

        # // You can refer to workspaces by index. However, keep in mind that
        # // niri is a dynamic workspace system, so these commands are kind of
        # // "best effort". Trying to refer to a workspace index bigger than
        # // the current workspace count will instead refer to the bottommost
        # // (empty) workspace.
        # //
        # // For example, with 2 workspaces + 1 empty, indices 3, 4, 5 and so on
        # // will all refer to the 3rd workspace.
        "Mod+1" = {
          action.focus-workspace = 1;
        };
        "Mod+2" = {
          action.focus-workspace = 2;
        };
        "Mod+3" = {
          action.focus-workspace = 3;
        };
        "Mod+4" = {
          action.focus-workspace = 4;
        };
        "Mod+5" = {
          action.focus-workspace = 5;
        };
        "Mod+6" = {
          action.focus-workspace = 6;
        };
        "Mod+7" = {
          action.focus-workspace = 7;
        };
        "Mod+8" = {
          action.focus-workspace = 8;
        };
        "Mod+9" = {
          action.focus-workspace = 9;
        };
        "Mod+Ctrl+1" = {
          action.move-column-to-workspace = 1;
        };
        "Mod+Ctrl+2" = {
          action.move-column-to-workspace = 2;
        };
        "Mod+Ctrl+3" = {
          action.move-column-to-workspace = 3;
        };
        "Mod+Ctrl+4" = {
          action.move-column-to-workspace = 4;
        };
        "Mod+Ctrl+5" = {
          action.move-column-to-workspace = 5;
        };
        "Mod+Ctrl+6" = {
          action.move-column-to-workspace = 6;
        };
        "Mod+Ctrl+7" = {
          action.move-column-to-workspace = 7;
        };
        "Mod+Ctrl+8" = {
          action.move-column-to-workspace = 8;
        };
        "Mod+Ctrl+9" = {
          action.move-column-to-workspace = 9;
        };

        # // Alternatively, there are commands to move just a single window:
        # // Mod+Ctrl+1 { move-window-to-workspace 1; }
        #
        # // Switches focus between the current and the previous workspace.
        # // Mod+Tab { focus-workspace-previous; }

        "Mod+Comma" = {
          action.consume-window-into-column = { };
        };
        "Mod+Period" = {
          action.expel-window-from-column = { };
        };

        # // There are also commands that consume or expel a single window to the side.
        # // Mod+BracketLeft  { consume-or-expel-window-left; }
        # // Mod+BracketRight { consume-or-expel-window-right; }

        "Mod+R" = {
          action.switch-preset-column-width = { };
        };
        "Mod+Shift+R" = {
          action.reset-window-height = { };
        };
        "Mod+F" = {
          action.maximize-column = { };
        };
        "Mod+Shift+F" = {
          action.fullscreen-window = { };
        };
        "Mod+C" = {
          action.center-column = { };
        };

        # // Finer width adjustments.
        # // This command can also:
        # // * set width in pixels: "1000"
        # // * adjust width in pixels: "-5" or "+5"
        # // * set width as a percentage of screen width: "25%"
        # // * adjust width as a percentage of screen width: "-10%" or "+10%"
        # // Pixel sizes use logical, or scaled, pixels. I.e. on an output with scale 2.0,
        # // set-column-width "100" will make the column occupy 200 physical screen pixels.
        "Mod+Minus" = {
          action.set-column-width = "-10%";
        };
        "Mod+Equal" = {
          action.set-column-width = "+10%";
        };

        # // Finer height adjustments when in column with other windows.
        "Mod+Shift+Minus" = {
          action.set-window-height = "-10%";
        };
        "Mod+Shift+Equal" = {
          action.set-window-height = "+10%";
        };

        # // Actions to switch layouts.
        # // Note: if you uncomment these, make sure you do NOT have
        # // a matching layout switch hotkey configured in xkb options above.
        # // Having both at once on the same hotkey will break the switching,
        # // since it will switch twice upon pressing the hotkey (once by xkb, once by niri).
        # // Mod+Space       { switch-layout "next"; }
        # // Mod+Shift+Space { switch-layout "prev"; }

        "Print" = {
          action.screenshot = { };
        };
        "Ctrl+Print" = {
          action.screenshot-screen = { };
        };
        "Alt+Print" = {
          action.screenshot-window = { };
        };

        # // The quit action will show a confirmation dialog to avoid accidental exits.
        "Mod+Shift+E" = {
          action.quit = { };
        };

        # // Powers off the monitors. To turn them back on, do any input like
        # // moving the mouse or pressing any other key.
        "Mod+Shift+P" = {
          action.power-off-monitors = { };
        };

        # Application keybinds
        "Mod+D" = {
          action.spawn = [ "fuzzel" ];
        };
        "Mod+W" = {
          action.spawn = [ "firefox" ];
        };
        "Mod+Return" = {
          action.spawn = [ "ghostty" ];
        };
      };

      switch-events = {
        "lid-close".action.spawn = [ "loginctl lock-session & systemctl suspend" ]; # TODO: Swaylock
      };

      layout = {
        gaps = 8;
        always-center-single-column = true;
        default-column-width = {
          proportion = 0.5;
        };

        preset-column-widths = [
          { proportion = 1.0 / 3.0; }
          { proportion = 1.0 / 2.0; }
          { proportion = 2.0 / 3.0; }
        ];

        preset-window-heights = [
          { proportion = 1.0 / 3.0; }
          { proportion = 1.0 / 2.0; }
          { proportion = 2.0 / 3.0; }
        ];
        # focus-ring = {
        #   enable = true;
        #   width = 4;
        #   inactive.color = "rgb(88 91 112)";
        #   active.color = "rgb(166 227 161)";
        # };
        # insert-hint = {
        #   enable = true;
        #   display.color = "rgb(166 227 161 20%)";
        # };
      };

      window-rules = [
        {
          geometry-corner-radius = {
            top-left = 12.0;
            top-right = 12.0;
            bottom-left = 12.0;
            bottom-right = 12.0;
          };
          clip-to-geometry = true;
        }
      ];

      spawn-at-startup = [ { command = [ "xwayland-satellite" ]; } ];
    };
    programs.niri = {
      enable = true;
      package = pkgs.niri-unstable;
      # inherit (cfg) config;
    };
  };

}
