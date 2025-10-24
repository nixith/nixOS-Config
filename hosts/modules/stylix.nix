{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  imports = [ inputs.stylix.nixosModules.stylix ];
  stylix = {
    image = ../../resources/wallpapers/everforest.webp;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest-dark-hard.yaml";
    enable = true;
    autoEnable = true;
    polarity = "dark";
    fonts = {
      monospace = {
        name = "Lilex Nerd Font Regular";
        package = pkgs.nerd-fonts.lilex;
      };
      # emoji = {
      #   package = pkgs.noto-fonts-monochrome-emoji;
      #   name = "Noto Emoji";
      # };
    };
    homeManagerIntegration = {
      autoImport = true;
      followSystem = true;
    };
    # targets.qt = {
    #   platform = "gnome";
    # };
  };

}
