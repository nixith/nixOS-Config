{
  config,
  pkgs,
  user,
  ...
}:
{

  programs.dconf.enable = true;

  programs = {
    nix-ld.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    fish = {
      enable = true;
    };
    nh = {
      enable = true;
    };

  };

  nix.settings = {
    extra-experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  #Distrobox

  # ZRAM
  zramSwap.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    description = "Me!";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "audio"
      "plugdev"
      "libvirtd"
    ];
    # import modules
  };

  networking.networkmanager.enable = true;

  system = {
    autoUpgrade = {
      enable = true;
      channel = "https://nixos.org/channels/nixos-unstable";
    };
    stateVersion = "22.11";
  };
}
