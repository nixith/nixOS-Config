# nixivim:
{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.nixith.neovim;
in
{

  options = {
    nixith.neovim.enable = lib.mkEnableOption "enable neovim config";
  };
  # move config files to .config
  config = lib.mkIf cfg.enable {
    # programs.neovim = {
    #   enable = true;
    #   defaultEditor = true;
    #   vimAlias = true;
    #   package = pkgs.nvim;
    # };
    home.packages = [ pkgs.nvim ];
  };
}
