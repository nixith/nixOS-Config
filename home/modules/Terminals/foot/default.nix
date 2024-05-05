{ ... }:
let
  termfont = {
    font = "LilexNerdFont";
    size = 14;
  };
in {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        shell = "fish";
        font = with termfont; "${font}:${builtins.toString size}";
      };
      colors = { # catppuccin colors
        background = "1e1e2e";
        bright0 = "a6adc8";
        bright1 = "f38ba8";
        bright2 = "a6e3a1";
        bright3 = "f9e2af";
        bright4 = "89b4fa";
        bright5 = "f5c2e7";
        bright6 = "94e2d5";
        bright7 = "45475a";
        foreground = "cdd6f4";
        jump-labels = "11111b fab387";
        regular0 = "bac2de";
        regular1 = "f38ba8";
        regular2 = "a6e3a1";
        regular3 = "f9e2af";
        regular4 = "89b4fa";
        regular5 = "f5c2e7";
        regular6 = "94e2d5";
        regular7 = "585b70";
        search-box-match = "cdd6f4 313244";
        search-box-no-match = "11111b f38ba8";
        selection-background = "414356";
        selection-foreground = "cdd6f4";
        urls = "89b4fa";
      };
    };
  };
}
