{ pkgs, monitors, ... }: ''
  exec= systemctl --user import-environment
  ${monitors}

  $rosewater = 0xfff5e0dc
  $flamingo  = 0xfff2cdcd
  $pink      = 0xfff5c2e7
  $mauve     = 0xffcba6f7
  $red       = 0xfff38ba8
  $maroon    = 0xffeba0ac
  $peach     = 0xfffab387
  $green     = 0xffa6e3a1
  $teal      = 0xff94e2d5
  $sky       = 0xff89dceb
  $sapphire  = 0xff74c7ec
  $blue      = 0xff89b4fa
  $lavender  = 0xffb4befe

  $text      = 0xffcdd6f4
  $subtext1  = 0xffbac2de
  $subtext0  = 0xffa6adc8

  $overlay2  = 0xff9399b2
  $overlay1  = 0xff7f849c
  $overlay0  = 0xff6c7086

  $surface2  = 0xff585b70
  $surface1  = 0xff45475a
  $surface0  = 0xff313244

  $base      = 0xff1e1e2e
  $mantle    = 0xff181825
  $crust     = 0xff11111b

  input {
      kb_file=
      kb_layout=
      kb_variant=
      kb_model=
      kb_options=
      kb_rules=
      numlock_by_default=true
      follow_mouse=1

      touchpad {
          natural_scroll=no
          disable_while_typing=true
      }
  }

  device:hanvon-ugee-deco-lw-pen {
        output = DP-2
    }
  general {
      sensitivity=1.0 # for mouse cursor

      gaps_in=3
      gaps_out=15
      border_size=2
      col.active_border=$mauve
      col.inactive_border=0x66333333
      layout="master"
      apply_sens_to_raw=0 # whether to apply the sensitivity to raw input (e.g. used by games where you aim using your mouse)
  }

  decoration {
      rounding=10
      blur=1
      blur_size=3 # minimum 1
      blur_passes=1 # minimum 1
      blur_new_optimizations=1
  }

  animations {
      enabled=1
      animation=windows,1,7,default
      animation=border,1,10,default
      animation=fade,1,10,default
      animation=workspaces,1,6,default
  }

  dwindle {
      pseudotile=0 # enable pseudotiling on dwindle
  }

  gestures {
      workspace_swipe=yes
  }

  misc {
      enable_swallow = true
      swallow_regex = kitty
      disable_hyprland_logo=true
      disable_splash_rendering=true
  }

  windowrule=float, blueberry.py
  windowrule=float, zoom
  windowrulev2 = noanim,class:^(flameshot)$
  windowrulev2 = float,class:^(flameshot)$

  bind=SUPER,Q,killactive,
  bind=SUPERSHIFT,L,exit,
  bind=SUPER,E,exec,nemo
  bind=SUPER,space,togglefloating,
  bind=SUPER,D,exec,rofi -show drun
  bind=SUPER,C,exec, rofi -show calc
  bind=SUPER,P,pseudo,
  bind=SUPER,Return,exec,kitty
  bind=SUPER,F,fullscreen,
  bind=SUPER,W,exec,firefox
  bind=SUPER,X,exec, systemctl suspend

  bind=,print,exec,XDG_CURRENT_DESKTOP=Sway flameshot gui
  bind=SUPER,print,exec,grimshot save area

  bind=SUPER,left,movefocus,l
  bind=SUPER,right,movefocus,r
  bind=SUPER,up,movefocus,u
  bind=SUPER,down,movefocus,d

  bind=SUPER,1,workspace,1
  bind=SUPER,2,workspace,2
  bind=SUPER,3,workspace,3
  bind=SUPER,4,workspace,4
  bind=SUPER,5,workspace,5
  bind=SUPER,6,workspace,6
  bind=SUPER,7,workspace,7
  bind=SUPER,8,workspace,8
  bind=SUPER,9,workspace,9
  bind=SUPER,0,workspace,10

  bind=ALT,1,movetoworkspace,1
  bind=ALT,2,movetoworkspace,2
  bind=ALT,3,movetoworkspace,3
  bind=ALT,4,movetoworkspace,4
  bind=ALT,5,movetoworkspace,5
  bind=ALT,6,movetoworkspace,6
  bind=ALT,7,movetoworkspace,7
  bind=ALT,8,movetoworkspace,8
  bind=ALT,9,movetoworkspace,9
  bind=ALT,0,movetoworkspace,10

  bind=SUPERALT,space,exec,playerctl play-pause
  bind=SUPERALT,bracketright,exec,playerctl next
  bind=SUPERALT,bracketleft,exec,playerctl previous
  bind=,XF86AudioRaiseVolume,exec,pactl set-sink-volume @DEFAULT_SINK@ +5%
  bind=,XF86AudioLowerVolume,exec,pactl set-sink-volume @DEFAULT_SINK@ -5%
  bind=,XF86AudioMute,exec,pactl set-sink-mute @DEFAULT_SINK@ toggle
  bind=,XF86AudioMicMute,exec,pactl set-source-mute @DEFAULT_SOURCE@ toggle
  bind=,XF86MonBrightnessDown,exec,brightnessctl set 10%-
  bind=,XF86MonBrightnessUp,exec,brightnessctl set +10%
  #mute audio upon start
  exec-once=pactl set-sink-mute @DEFAULT_SINK@ toggle
  exec-once=pactl set-source-mute @DEFAULT_SOURCE@ toggle

   bindm=SUPER,mouse:272,movewindow
   bindm=SUPER,mouse:273,resizewindow

  exec-once=emacs --daemon
  exec-once=XDG_CURRENT_DESKTOP=Sway flameshot
  exec-once="${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1
  exec-once=wlsunset -l 35.6 -L -78.8 # Screen dimmer/oranger based on sunrise and sunset
  exec-once=waybar # -c ~/.config/hypr/waybar/config.json -s ~/.config/hypr/waybar/style.css
  exec=swaybg -i ~/Pictures/wallpapers/tropic_island_night.jpg -m fill
  exec=export XDG_CURRENT_DESKTOP="Sway"
  #exec-once= wezterm
''
