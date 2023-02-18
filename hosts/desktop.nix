# File that contains the defaults for graphical desktops
{ config, pkgs, user, ... }:

{

  # Graphical Necesities
  programs.dconf.enable = true;
  security.polkit.enable = true;
  qt = {
    platformTheme = "gtk2";
    enable = true;
    style = "gtk2";
  };
  environment.systemPackages = with pkgs; [ usbutils android-udev-rules ];

  # steam has to be done here
  programs.steam.enable = true;

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
    extraPortals = [ ];
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
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    description = "Me!";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "plugdev" ];
    # import modules
    packages = with pkgs; [ ];
    shell = pkgs.bashInteractive;
    initialPassword = "password"; # TODO fix later with sops-nix
  };

  services.udisks2 = { enable = true; };
  services.udev = {
    enable = true;
    packages = [ pkgs.udisks2 ];
  };

  # Install Fonts
  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs;
      [ (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; }) ];
  };
}
