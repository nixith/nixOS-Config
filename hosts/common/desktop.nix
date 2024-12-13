# File that contains the defaults for graphical desktops
{ config, pkgs, user, inputs, ... }:
let
  gamescopeEnv = {
    # __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };
  gamescopeArgs = [ "SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS=0" "-e" ];
in {
  zramSwap.enable = true;
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  boot = {
    extraModulePackages = with config.boot.kernelPackages;
      [
        v4l2loopback # OBS virtual camera
      ];
    extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';
  };

  programs.nix-ld = {
    enable = true;
    libraries = (pkgs.steam.args.multiPkgs pkgs)
      ++ (with pkgs; [ xorg.libxcb libxkbcommon wayland ]);
  };
  programs.thunderbird.enable = true;
  # Graphical Necesities
  programs.dconf.enable = true;
  security.polkit.enable = true;
  qt = {
    platformTheme = "gnome";
    enable = true;
    style = "adwaita-dark";
  };

  environment.systemPackages = with pkgs; [
    ffmpeg
    usbutils
    android-udev-rules
    libva-utils
    brillo
    # nix-ld
    (lib.hiPrio (writeShellScriptBin "python3" ''
      LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH exec -a $0 ${python3}/bin/python3 "$@"''))
    (pkgs.wrapOBS {
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-vkcapture
        obs-vaapi
        obs-backgroundremoval
        droidcam-obs
        obs-pipewire-audio-capture
      ];
    })
  ];

  # keyring stuff
  services.gnome.gnome-keyring.enable = true;

  # programs.gamescope = {
  #   enable = true;
  #   capSysNice = true;
  #   package = pkgs.gamescope-wsi;
  #   env = gamescopeEnv;
  #   args = gamescopeArgs;
  # };

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";
    displayManager.startx.enable = true;
  };
  services.gpm = {
    enable = true;
    protocol = "imps2";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  # for a WiFi printer
  services.avahi.openFirewall = true;

  # Enable flatpak
  xdg.portal = {
    xdgOpenUsePortal = true;
    enable = true;
    extraPortals = [
      #pkgs.xdg-desktop-portal-wlr
      #inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
      #pkgs.xdg-desktop-portal
      #inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
  };
  services.flatpak.enable = true;
  services.seatd.enable = true;
  services.upower.enable = true;
  services.dbus = {
    enable = true;
    implementation = "dbus";
    apparmor = "enabled";
  };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  environment.shells = with pkgs; [ fish bash ];
  programs.fish.enable = true;

  users.users.${user} = {
    isNormalUser = true;
    uid = 1000;
    description = "Me!";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "audio"
      "plugdev"
      "fuse"
      "jack"
      "seatd"
    ];
    # import modules
    packages = with pkgs; [ glibc libredirect libdrm mesa ];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPLMtBjXvadChqa2pZIvJ6eHrkcYD87/skfl3Kjwg6dO alice@nixos"
    ];
  };
  programs.kdeconnect.enable = true;
  services.udisks2 = { enable = true; };
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udev = {
    enable = true;
    packages = [ pkgs.udisks2 pkgs.platformio pkgs.openocd ];
  };

  hardware.logitech = {
    wireless.enable = true;
    wireless.enableGraphical = true;
  };

  hardware.brillo.enable = true;

  programs.gamemode = {
    enable = true;
    enableRenice = true;
    settings = {
      general = { renice = 10; };

      # Warning: GPU optimisations have the potential to damage hardware
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 0;
        amd_performance_level = "high";
        nv_powermizer_mode = 0;
      };
    };
  };
  # video acceleration
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [ libvdpau-va-gl vaapiVdpau libvdpau ];
  };

  # Install Fonts
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      (nerdfonts.override {
        fonts = [
          "FiraCode"
          "JetBrainsMono"
          "Iosevka"
          "Inconsolata"
          "ComicShannsMono"
          "DaddyTimeMono"
          "FantasqueSansMono"
          "Lilex"
          "Monofur"
        ];
        enableWindowsFonts = true;
      })
      julia-mono
    ];
  };
}
