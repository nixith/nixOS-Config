nixivim:
{ pkgs, lib, config, ... }:
let cfg = config.nixith.neovim;
in {

  options = {
    nixith.neovim.enable = lib.mkEnableOption "enable neovim config";
  };
  # move config files to .config
  config = lib.mkIf cfg.enable {
    home.packages = [ nixivim.packages.${pkgs.system}.default ];
  };
}
