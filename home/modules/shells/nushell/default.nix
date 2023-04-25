{
  pkgs,
  home,
  ...
}: {
  programs.starship.enableNushellIntegration = true;

  programs.nushell = {
    enable = true;
  };
}
