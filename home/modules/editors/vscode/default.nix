{
  home,
  pkgs,
  ...
}: {
  programs.vscode = {
    enable = true;
    programs.vscode.mutableExtensionsDir = true;
  };
}
