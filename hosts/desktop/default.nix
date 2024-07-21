{ config, lib, pkgs, user, ... }:
let
  hostname = "Galaxia";
  kernel = pkgs.linuxPackages_latest;
in {
  imports = [
    ./hardware-configuration.nix # import important autogenerated stuff
    ../common/nvidia/nvidia.nix

  ];

  # btrfs options
  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [ "compress=zstd" "noatime" ];
    #"/swap".options = [ "noatime" ];
  };

  # some weird workarounds for hyprland and hostname detection
  environment.variables = { HOSTNAME = hostname; };
  nixpkgs.config.allowUnfree = true;

  boot = {
    supportedFilesystems = [ "btrfs" ];

    loader.efi = {
      canTouchEfiVariables = true;
      #efiSysMountPoint = "/boot/";
    };

    loader.grub = {
      enable = false;
      device = "nodev";
      efiSupport = true;
      #useOSProber = true; # enables dual boot;
    };

    loader.systemd-boot = { enable = true; };
  };

  networking = {
    hostName = hostname; # Define your hostname.
  };

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking

  # Set your time zone.
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    description = "Me!";
    extraGroups =
      [ "networkmanager" "wheel" "video" "audio" "podman" "render" ];
    # import modules
    packages = with pkgs; [ ];
    hashedPassword =
      "$6$8a7Hgdgv5zOp6w5u$Kro/9wAni3mtXOGhc8bWxYCa8aijTqowdA1lXucHiLxtct/9ZGAr9bzwePv5cfjnQSUG2YOvJOMYpVF0j75G91"; # TODO fix with sops-nix
  };

  environment.shells = with pkgs; [ fish bash dash ];
  # Allow unfree packages

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  networking.firewall.allowedTCPPortRanges = [{
    from = 1714;
    to = 1764;
  }];
  networking.firewall.allowedUDPPortRanges = [{
    from = 1714;
    to = 1764;
  }];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  #  system.stateVersion = "22.11"; # Did you read the comment?
  system = {
    autoUpgrade = {
      enable = true;
      channel = "https://nixos.org/channels/nixos-unstable";
    };
    stateVersion = "22.11";
  };

  # appimage compat
  programs.appimage = {
    enable = true;
    binfmt = true;
    package = pkgs.appimage-run.override {
      extraPkgs = pkgs: [ pkgs.ffmpeg pkgs.imagemagick ];
    };
  };
  specialisation."nvk".configuration = {
    environment.systemPackages = with pkgs; [ mesa ];
    environment.etc."specialisation".text = "nvk";
    boot.kernelParams = [ "nouveau.config=NvGspRm=1" ];
    services.xserver.videoDrivers = [ "nvk" "nouveau" "modesetting" "fbdev" ];
  };
}
