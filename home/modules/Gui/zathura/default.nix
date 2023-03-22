{ home, ... }:
{
  programs.zathura = {
      enable = true;
      extraconfig = ''
      include catppuccin-mocha
      '';
    };
  xdg.configFile."zathura/catppuccin-mocha".source = ./catppuccin-mocha;
 
}
