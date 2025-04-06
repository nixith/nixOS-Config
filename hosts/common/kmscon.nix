{ pkgs, ... }:
{
  services.kmscon = {
    enable = true;
    hwRender = true;
    fonts = [
      {
        name = "Lilex Nerd Font Regular";
        package = pkgs.nerdfonts.override { fonts = [ "Lilex" ]; };
      }
    ];
    extraConfig = "font-size=14";
    extraOptions = "--term xterm-256color";
  };

  services.gpm = {
    enable = true;
  };
}
