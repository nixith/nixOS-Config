# This is my NixOS configuration

# How this is split up

## flake

the flake is essentially the command center from which
to build a conifg. You tell it to build, and it does.

## ./hosts

a directory cotnaining the different hosts and a `default.nix`
that tells **nixOS** how to use them.

### How hosts are defined

Every nixOS host pulls from a common system config
each host has an extra configuration file, and a `hardware-config.nix`.
These specify the hardware for the device, and extra device-specific
options such as kernel modules, boot configuration, and static IP.

It should be noted that ** NOTHING THAT CAN BE DONE WITH HOME MANAGER ** should go here.
the goal is to be stable and control hardware / low level things that shouldn't change.
Everything else goes in the home-manager config.

## ./HomeManager

Here is where I define the different config files for my different use cases.
Ideally, everything is as similar as possible.
Eventually, I'd like everything to be one config that can simply tell when it needs to change.

until then, modules will be created in differnet folders. For example:

[Hyprland]

- default.nix
- HyprLandNvidia.nix
- hyprland.conf (pulled for config, and maybe edited for monitor.conf)


## Programs to configure
- [X] home-manager
- [X] exa
- [X] zsh
- [X] Starship
- [X] helix
 - [X] lsps (different language modules?)
- nvim (For now)
- [ ] wezterm
- [ ] kitty
- [X] hyprland
- [X] xournalpp
 - [X] config
- [X] flatpak
- [X] logseq
- [ ] waybar
- [ ] btop
- [X] steam
- [ ] rofi-wayland
 - [ ] catppuccin
 - [ ] calculator
- [X] gtk (return later if needed) (Can do after install)
- [ ] htop
- [X] logseq
- [X] nemo


### Extra Programs
- [x] dash shell 
- [X] Libreoffice
- [ ] mpv
- [x] zathura
- [X] polymc
- [X] autocpufreq
- [X] thermald
- [X] calibre
- [X] carla
- [X] fzf
- [X] bluez
- [X] blueberry
- [X] bluetoothctl
- [X] firefox-wayland
- [X] noisetorch
- [X] pavucontrol
- [X] gimp
- [X] playerctl
- [X] wlsunset
- [X] gnome polkit
- [X] virshmanager
flatpaks
 - [ ] flatseal
 - [ ] zoom

