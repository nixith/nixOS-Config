{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableVteIntegration = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
  };
}
