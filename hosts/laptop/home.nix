{
  user,
  self,
  inputs,
  extraMopidyConfigs ? [ ],
  ...
}:

let

  pins = import ../../npins;

  niri-flake-repo = pins.niri;
  compat = import pins.flake-compat;

  niri = compat.load {
    src = niri-flake-repo;
  };
in
{
  imports = [

    (import ../../home/modules/modules.nix { inherit inputs; })
    niri.homeModules.niri
    niri.homeModules.stylix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "${user}";
  home.homeDirectory = "/home/${user}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  wayland.windowManager.river = {
    enable = true;
  };

  nixith = {
    neovim.enable = true;
    gui.enable = true;
    cli.enable = true;
    mpv.enable = true;
    fish.enable = true;
    starship.enable = true;
    music = {
      enable = true;
      extraConfigFiles = extraMopidyConfigs;
    };
    # syncthing.enable = true;
    river.enable = false;
    niri = {
      enable = true;
      config = builtins.readFile ./config.kdl;
    };
    vicinae.enable = true;
    ghostty.enable = true;
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
