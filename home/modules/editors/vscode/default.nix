{ home, pkgs, ... }:
{
  programs.vscode = {
    enable = false;
    mutableExtensionsDir = true;
    package = pkgs.vscode-fhs;
  };
}
