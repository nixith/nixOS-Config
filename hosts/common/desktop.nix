# File that contains the defaults for graphical desktops
{
  config,
  pkgs,
  user,
  inputs,
  ...
}: {
  zramSwap.enable = true;

  # Graphical Necesities
  programs.dconf.enable = true;
  security.polkit.enable = true;
  qt = {
    platformTheme = "gtk2";
    enable = true;
    style = "gtk2";
  };
  environment.systemPackages = with pkgs; [usbutils android-udev-rules libva-utils jack2 brillo];

  # steam has to be done here
  programs.steam = {
    package = pkgs.steam.override {
      extraEnv = {
        RADV_TEX_ANISO = 16;
      };
      extraLibraries = pkgs:
        with pkgs; [
          openssl
          gamemode
        ];
      extraProfile = "export STEAM_EXTRA_COMPAT_TOOLS_PATHS='${inputs.nix-gaming.packages.${pkgs.system}.proton-ge}'";
    };
    enable = true;
    gamescopeSession = {
      enable = true;
    };
  };

  programs.gamescope = {
    enable = true;
    capSysNice = true;
    env = {
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };
  };

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    displayManager.startx.enable = true;
  };
  services.gpm = {
    enable = true;
    protocol = "imps2";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  # for a WiFi printer
  services.avahi.openFirewall = true;

  # Enable flatpak
  xdg.portal = {
    xdgOpenUsePortal = true;
    enable = true;
    extraPortals = [
      #pkgs.xdg-desktop-portal-wlr
      inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal
      #inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
  };
  services.flatpak.enable = true;
  services.upower.enable = true;
  services.dbus = {
    enable = true;
    implementation = "broker";
  };

  # Enable sound with pipewire.
  sound.enable = true;
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
  environment.shells = with pkgs; [fish bash];
  programs.fish.enable = true;

  users.users.${user} = {
    isNormalUser = true;
    description = "Me!";
    extraGroups = ["networkmanager" "wheel" "video" "audio" "plugdev" "fuse" "jack"];
    # import modules
    packages = with pkgs; [ffmpeg glibc libredirect libdrm mesa];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPLMtBjXvadChqa2pZIvJ6eHrkcYD87/skfl3Kjwg6dO ryan@nixos"
    ];
    initialPassword = "password"; # TODO fix later with sops-nix
  };
  programs.kdeconnect.enable = true;
  services.udisks2 = {enable = true;};
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udev = {
    enable = true;
    packages = [
      pkgs.udisks2
      pkgs.platformio
      pkgs.openocd
    ];
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
      general = {
        renice = 10;
      };

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
    extraPackages = with pkgs; [
      libvdpau-va-gl
      vaapiVdpau
      libvdpau
    ];
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
    ];
  };
}
