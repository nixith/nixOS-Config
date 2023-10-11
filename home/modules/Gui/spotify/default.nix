{
  computer,
  inputs,
  pkgs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in {
  imports = [inputs.spicetify-nix.homeManagerModule];

  programs.spicetify = {
    enable = true;
    theme = {
      name = "catppuccin";
      appendName = true;
      src = inputs.catppuccin-spicetify;
      injectCss = true;
      replaceColors = true;
      overwriteAssets = true;
      sidebarConfig = false;
    };
    colorScheme = "mocha";

    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplayMod
      bookmark
      keyboardShortcut
      popupLyrics
      shuffle
      powerBar
      wikify
      songStats
      autoVolume
    ];

    enabledCustomApps = with spicePkgs.apps; [
      new-releases
      lyrics-plus
      marketplace
    ];
  };
}
