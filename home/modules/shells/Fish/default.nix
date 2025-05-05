{ lib
, config
, pkgs
, ...
}:

let
  cfg = config.nixith.fish;
in
{

  options = {
    nixith.fish.enable = lib.mkEnableOption "enable fish & related plugins";
  };
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      vivid # generate LS_COLORS for scheme
    ];
    programs.fish = {
      enable = true;
      shellAbbrs = {
        ls = "eza";
        la = "eza -a";
        ll = "eza -al";
      };
      shellInit = builtins.readFile ./config.fish;
      plugins =
        let
          fishPlugin = plugin_name: {
            name = plugin_name;
            inherit (pkgs.fishPlugins.${plugin_name}) src;
          };
        in
        [
          #{
          #  name = "fzf.fish";
          #  src = inputs.fish-fzf;
          #}
          (fishPlugin "pisces")
          (fishPlugin "z")
          (fishPlugin "fzf-fish")
        ];
    };

    programs.yazi = {
      enable = true;
      enableFishIntegration = true;
    };
    programs.carapace = {
      enable = true;
      enableFishIntegration = true;
    };
    programs.direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };
    };
  };
}
