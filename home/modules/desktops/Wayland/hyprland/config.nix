{ pkgs, monitors, HyprEnv, ... }:
let
  term = "foot";
  # hyprlang
in ''
    ${HyprEnv}

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

  env = HYPRCURSOR_THEME,catppuccin-mocha-dark-cursors
  env = HYPRCURSOR_SIZE,16
    input {
        kb_file=
        kb_layout=
        kb_variant=
        kb_model=
        kb_options=ctrl:nocaps
        kb_rules=
        numlock_by_default=true
        follow_mouse=1

        touchpad {
            natural_scroll=no
            disable_while_typing=true
        }
    }

    general {
        sensitivity=1.0 # for mouse cursor

        gaps_in=3
        gaps_out=10
        border_size=2
        col.active_border=$mauve
        col.inactive_border=0x66333333
        layout="master"
        apply_sens_to_raw=0 # whether to apply the sensitivity to raw input (e.g. used by games where you aim using your mouse)
    }

    xwayland {
      force_zero_scaling = true
    }


    decoration {
        rounding=10
        blur {
        popups = true
        enabled=1
        #xray = 1
        size=8 # minimum 1
        passes=1 # minimum 1
        new_optimizations=1
        noise = 0.015
        vibrancy = 0.18
        }
    }

    animations {
        #animation=windows,1,7,default
        #animation=border,1,10,default
        #animation=fade,1,10,default
        #animation=workspaces,1,6,default
    }

    dwindle {
        pseudotile=0 # enable pseudotiling on dwindle
    }

    gestures {
        workspace_swipe=yes
    }

    misc {
        enable_swallow = true
        swallow_regex = ${term}
        disable_hyprland_logo=true
        disable_splash_rendering=true
    }

    windowrule=float, blueberry.py
    windowrule=float, zoom
    windowrulev2 = noanim,class:^(flameshot)$
    windowrulev2 = float,class:^(flameshot)$
    windowrulev2 = fakefullscreen,class:^(flameshot)$
    layerrule = noanim, anyrun
    windowrulev2 = move 0 0,class:^(flameshot)$
    windowrulev2 = noborder,class:^(flameshot)$


    # KDE CONNECT Presentation Mode
    windowrule=opacity 1, title:KDE Connect Daemon
    windowrule=noblur, title:KDE Connect Daemon
    windowrule=noborder, title:KDE Connect Daemon
    windowrule=noshadow, title:KDE Connect Daemon
    windowrule=noanim, title:KDE Connect Daemon
    windowrule=noblur, title:KDE Connect Daemon
    windowrule=nofocus, title:KDE Connect Daemon
    windowrule=suppressevent fullscreen, title:KDE Connect Daemon
    windowrule=float, title:KDE Connect Daemon
    windowrule=pin, title:KDE Connect Daemon
    windowrule=xray on, title:KDE Connect Daemon
    windowrule=minsize 1920 1080, title:KDE Connect Daemon
    windowrule=move 0 0, title:KDE Connect Daemon
    windowrule=size 100% 100%, title:KDE Connect Daemon

    bind=SUPER,Q,killactive,
    #bind=SUPERSHIFT,L,exit,
    bind=SUPERSHIFT,End,exit
    bind=SUPER,E,exec,nemo
    bind=SUPER,space,togglefloating,
    bind=SUPER,D,exec,anyrun
    bind=SUPERSHIFT,D,exec,anyrun
    bind=SUPER,C,exec, rofi -show calc
    bind=SUPER,P,pseudo,
    bind=SUPER,Return,exec,${term}
    bind=SUPER,F,fullscreen,
    bind=SUPER,W,exec,firefox
    bindl=SUPER,X,exec, systemctl suspend

    bind=,print,exec,XDG_CURRENT_DESKTOP=Sway flameshot gui
    bind=SUPER,print,exec,grimshot copy area

    #window focus with vim binds
    bind=SUPER,H,movefocus,l
    bind=SUPER,L,movefocus,r
    bind=SUPER,K,movefocus,u
    bind=SUPER,J,movefocus,d

    #moving windows with vim binds
    bind=SUPERSHIFT,H,movewindow,l
    bind=SUPERSHIFT,L,movewindow,r
    bind=SUPERSHIFT,K,movewindow,u
    bind=SUPERSHIFT,J,movewindow,d



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

    bindl=SUPERALT,space,exec,playerctl --player=%any,firefox play-pause
    bindl=SUPERALT,bracketright,exec,playerctl --player=%any,firefox next
    bindl=SUPERALT,bracketleft,exec,playerctl --player=%any,firefox previous
    bindl=,XF86AudioPlay,exec,playerctl --player=%any,firefox play-pause
    binde=,XF86AudioRaiseVolume,exec,wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2.5%+ && ~/.config/hypr/scripts/ewwVolUpdate.sh
    binde=,XF86AudioLowerVolume,exec,wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2.5%- && ~/.config/hypr/scripts/ewwVolUpdate.sh
    binde=SUPER,XF86AudioRaiseVolume,exec,wpctl set-volume -l 1 @DEFAULT_AUDIO_SOURCE@ 2.5%+ && ~/.config/hypr/scripts/ewwVolUpdate.sh
    binde=SUPER,XF86AudioLowerVolume,exec,wpctl set-volume -l 1 @DEFAULT_AUDIO_SOURCE@ 2.5%- && ~/.config/hypr/scripts/ewwVolUpdate.sh

    bind=,XF86AudioMute,exec,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && ~/.config/hypr/scripts/ewwVolUpdate.sh
    bind=SUPER,XF86AudioMute,exec,wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle && ~/.config/hypr/scripts/ewwVolUpdate.sh
    bind=,XF86AudioMicMute,exec,wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle && ~/.config/hypr/scripts/ewwVolUpdate.sh
    binde=,XF86MonBrightnessDown,exec,brightnessctl set 10%-
    binde=,XF86MonBrightnessUp,exec,brightnessctl set +10%

    #TODO: change to pipewire module - stop depending on carla
    exec-once=${pkgs.pipewire}/bin/pw-cli load-module module-null-sink media.class=Audio/Source/Virtual sink_name=my-virtualmic channel_map=front-left,front-right
    #mute audio upon start
    exec-once=wpctl set-mute @DEFAULT_AUDIO_SINK@ 1
    exec-once=wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 1


    bindm=SUPER,mouse:272,movewindow
    bindm=SUPER,mouse:273,resizewindow

    exec-once=XDG_CURRENT_DESKTOP=Sway flameshot
    exec=${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1
    exec-once=wlsunset -l 35.6 -L -78.8 # Screen dimmer/oranger based on sunrise and sunset
    exec=eww daemon -c ~/.config/eww/
    exec=eww open-many $(eww list-windows | grep '^[^\*]')
    exec=~/.config/hyprland/scripts/ewwVolUpdate.sh
''
