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
  environment.systemPackages = with pkgs; [usbutils android-udev-rules libva-utils];

  # steam has to be done here
  programs.steam.enable = false;

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    displayManager.startx.enable = true;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable flatpak
  xdg.portal = {
    enable = true;
    extraPortals = [
      #pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal
      pkgs.xdg-desktop-portal-gtk
    ];
  };
  services.flatpak.enable = true;

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

  users.users.${user} = {
    isNormalUser = true;
    description = "Me!";
    extraGroups = ["networkmanager" "wheel" "video" "audio" "plugdev"];
    # import modules
    packages = with pkgs; [ffmpeg glibc libredirect libdrm mesa];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPLMtBjXvadChqa2pZIvJ6eHrkcYD87/skfl3Kjwg6dO ryan@nixos"
    ];
    initialPassword = "password"; # TODO fix later with sops-nix
  };
  programs.fish.enable = true;
  programs.kdeconnect.enable = true;
  services.udisks2 = {enable = true;};
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udev = {
    enable = true;
    packages = [pkgs.udisks2];
  };

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
    enableDefaultFonts = true;
    fonts = with pkgs; [(nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono"];})];
  };
}
