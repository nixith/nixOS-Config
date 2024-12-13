{ config, lib, pkgs, ... }:
let cfg = config.nixith.river;
in {

  imports = [ ../General/eww ../General/mako ];

  options.nixith.river = {
    enable = lib.mkEnableOption "enable river";
    # config = lib.mkOption {
    #   type = lib.types.str;
    #   description = "niri config (make into nix config eventually)";
    # };
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
    #xdg.portal = { enable = true; };
    nixith.anyrun.enable = true;
    home.packages = with pkgs; [
      goofcord
      rivercarro
      easyeffects
      wl-clipboard-rs
      pamixer
      brightnessctl
      playerctl

    ];
    wayland.windowManager.river = {
      enable = true;
      systemd = {
        variables = [ "--all" ];
        extraCommands = [
          "systemctl --user restart river-session.target"
          "systemctl --user restart xdg-desktop-portal.service"
        ];
      };
      extraConfig = # bash
        ''
          # this is the example configuration file for river. if you wish to edit this, you will probably want to copy it to $xdg_config_home/river/init or $home/.config/river/init first. see the river(1), riverctl(1), and rivercarro(1) man pages for complete documentation. 
          # note: the "super" modifier is also known as logo, gui, windows, mod4, etc. 
          # super+Shift+return to start an instance of foot (https://codeberg.org/dnkl/foot) riverctl map normal super+shift return spawn foot 
          #super+q to close the focused view
          riverctl map normal Super Q close 
          #Super+Shift+e to exit river 
          riverctl map normal Super+Shift E exit 
          # vim motion window management 
          # move focus
          riverctl map normal Super j focus-view down 
          riverctl map normal Super k focus-view up 
          riverctl map normal Super h focus-view left 
          riverctl map normal Super l focus-view right 
          #move windows

          riverctl map normal Super+Shift j swap down 
          riverctl map normal Super+Shift k swap up 
          riverctl map normal Super+Shift h swap left 
          riverctl map normal Super+Shift l swap right 

          riverctl map normal Super+Control h send-layout-cmd rivercarro "main-ratio -0.05"
          riverctl map normal Super+Control l send-layout-cmd rivercarro "main-ratio +0.05" 
          # note: cannot adjust veritcal size for now.... worth looking into otther layouts 

          # Super+Shift+j and super+shift+k to swap the focused view with the next/previous view in the layout stack
          riverctl map normal Super+Shift j swap next
          riverctl map normal Super+Shift k swap previous 
          # Super+period and super+comma to focus the next/previous output
          riverctl map normal Super U focus-output next
          riverctl map normal Super I focus-output previous
          # Super+Shift+{period,comma} to send the focused view to the next/previous output
          riverctl map normal Super+Shift u send-to-output next
          riverctl map normal Super+Shift i send-to-output previous 
          # applications

          riverctl map normal Super return spawn foot 
          riverctl map normal Super w spawn firefox 
          riverctl map normal Super e spawn nemo 
          #application launcher
          riverctl map normal Super d spawn anyrun

          # Super+h and super+l to decrease/increase the main ratio of rivercarro(1)

          # Super+Shift+h and super+shift+l to increment/decrement the main count of rivercarro(1)
          riverctl map normal Super+Shift h send-layout-cmd rivercarro "main-count +1"
          riverctl map normal Super+Shift l send-layout-cmd rivercarro "main-count -1"

          # Super+Alt+{h,j,k,l} to move views
          riverctl map normal Super+Alt h move left 100
          riverctl map normal Super+Alt j move down 100
          riverctl map normal Super+Alt k move up 100
          riverctl map normal Super+Alt l move right 100

          # Super+Alt+Control+{h,j,k,l} to snap views to screen edges
          riverctl map normal Super+Alt+Control h snap left
          riverctl map normal Super+Alt+Control j snap down
          riverctl map normal Super+Alt+Control k snap up
          riverctl map normal Super+Alt+Control l snap right

          # Super+Alt+Shift+{h,j,k,l} to resize views
          riverctl map normal Super+Alt+Shift h resize horizontal -100
          riverctl map normal Super+Alt+Shift j resize vertical 100
          riverctl map normal Super+Alt+Shift k resize vertical -100
          riverctl map normal Super+Alt+Shift l resize horizontal 100

          # Super + left mouse button to move views
          riverctl map-pointer normal Super BTN_LEFT move-view

          # Super + right mouse button to resize views
          riverctl map-pointer normal Super BTN_RIGHT resize-view

          # Super + middle mouse button to toggle float
          riverctl map-pointer normal Super BTN_MIDDLE toggle-float

          for i in $(seq 1 9); do
            tags=$((1 << ($i - 1)))

            # Super+[1-9] to focus tag [0-8]
            riverctl map normal Super $i set-focused-tags $tags

            # Super+Shift+[1-9] to tag focused view with tag [0-8]
            riverctl map normal Super+Shift $i set-view-tags $tags

            # Super+Control+[1-9] to toggle focus of tag [0-8]
            riverctl map normal Super+Control $i toggle-focused-tags $tags

            # Super+Shift+Control+[1-9] to toggle tag [0-8] of focused view
            riverctl map normal Super+Shift+Control $i toggle-view-tags $tags
          done

          # Super+0 to focus all tags
          # Super+Shift+0 to tag focused view with all tags
          #
          all_tags=$(((1 << 32) - 1))
          riverctl map normal Super+Shift c toggle-view-tags 31 # communication tags
          riverctl map normal Super+Shift m toggle-view-tags 30 # music tags
          riverctl map normal Super 0 set-focused-tags $all_tags
          riverctl map normal Super+Shift 0 set-view-tags $all_tags

          # Super+space to toggle float
          riverctl map normal Super space toggle-float

          # Super+f to toggle fullscreen
          riverctl map normal Super f toggle-fullscreen

          # Super+{up,right,down,left} to change layout orientation
          riverctl map normal Super up send-layout-cmd rivercarro "main-location top"
          riverctl map normal Super right send-layout-cmd rivercarro "main-location right"
          riverctl map normal Super down send-layout-cmd rivercarro "main-location bottom"
          riverctl map normal Super left send-layout-cmd rivercarro "main-location left"

          # declare a passthrough mode. this mode has only a single mapping to return to
          # normal mode. this makes it useful for testing a nested wayland compositor
          riverctl declare-mode passthrough

          # Super+f11 to enter passthrough mode
          riverctl map normal Super f11 enter-mode passthrough

          # Super+f11 to return to normal mode
          riverctl map passthrough Super f11 enter-mode normal

          # various media key mapping examples for both normal and locked mode which do
          # not have a modifier
          for mode in normal locked; do
            # eject the optical drive (well if you still have one that is)
            riverctl map $mode None xf86eject spawn 'eject -t'

            # Control pulse audio volume with pamixer (https://github.com/cdemoulins/pamixer)
            riverctl map $mode None xf86audioraisevolume spawn 'pamixer -i 5'
            riverctl map $mode None xf86audiolowervolume spawn 'pamixer -d 5'
            riverctl map $mode None xf86audiomute spawn 'pamixer --toggle-mute'

            # Control mpris aware media players with playerctl (https://github.com/Altdesktop/playerctl)
            riverctl map $mode None xf86audiomedia spawn 'playerctl play-pause'
            riverctl map $mode None xf86audioplay spawn 'playerctl play-pause'
            riverctl map $mode None xf86audioprev spawn 'playerctl previous'
            riverctl map $mode None xf86audionext spawn 'playerctl next'

            # Control screen backlight brightness with brightnessctl (https://github.com/hummer12007/brightnessctl)
            riverctl map $mode None xf86monbrightnessup spawn 'brightnessctl set +5%'
            riverctl map $mode None xf86monbrightnessdown spawn 'brightnessctl set 5%-'
          done

          # set background and border color
          riverctl border-color-unfocused 0x586e75
          riverctl background-color 0x1e1e2eaf
          riverctl border-color-focused 0xb4befea2

          # set keyboard repeat rate
          riverctl set-repeat 50 300

          # make all views with an app-id that starts with "float" and title "foo" start floating.
          riverctl rule-add -app-id 'float*' -title 'foo' float

          # make all views with app-id "bar" and any title use client-side decorations
          riverctl rule-add -app-id "bar" csd

          # set the default layout generator to be rivercarro and start it.
          # river will send the process group of the init executable sigterm on exit.
          riverctl default-layout rivercarro
          rivercarro -outer-gaps 0 -per-tag &

          # input config
          riverctl hide-cursor when-typing enabled
          riverctl set-cursor-warp on-focus-change
          riverctl input pointer-1267-13-Elan_Touchpad tap enabled
          riverctl input pointer-1267-13-Elan_Touchpad natural-scroll enabled

          ### app specific items
          # communication tag
        '';
    };
  };

}
