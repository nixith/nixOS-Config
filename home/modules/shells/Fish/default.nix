{
  lib,
  config,
  pkgs,
  ...
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
      shellInit = lib.concatStringsSep "\n" [
        (builtins.readFile ./config.fish)
        # fish
        ''
          function fish_hybrid_key_bindings --description \
          "Vi-style bindings that inherit emacs-style bindings in all modes"
              for mode in default insert visual
                  fish_default_key_bindings -M $mode
              end
              fish_vi_key_bindings --no-erase
          end
          set -g fish_key_bindings fish_hybrid_key_bindings
          fish_hybrid_key_bindings
        ''
      ];
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
          # (fishPlugin "fzf-fish")
        ];
    };

    programs = {
      yazi = {
        enable = true;
        enableFishIntegration = true;
      };
      carapace = {
        enable = true;
        enableFishIntegration = true;
      };
      direnv = {
        enable = true;
        nix-direnv = {
          enable = true;
        };
      };
      mcfly = {
        enable = true;
        fzf.enable = true;
      };
    };
  };
}
