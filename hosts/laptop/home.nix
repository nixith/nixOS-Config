{ user, self, ... }:

{
  imports = [ self.homeManagerModules.default ];
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
  home.sessionVariables = { EDITOR = "nvim"; };

  nixith = {
    neovim.enable = true;
    gui.enable = true;
    cli.enable = true;
    rio.enable = true;
    fish.enable = true;
    starship.enable = true;
    niri = {
      enable = true;
      config = builtins.readFile ./config.kdl;
    };
    foot.enable = true;
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
