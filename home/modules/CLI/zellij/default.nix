{ lib, config, ... }:
let cfg = config.nixith.zellij;
in {
  options = {
    nixith.zellij.enable = lib.mkEnableOption "Enable zellij config";
  };

  config = lib.mkIf cfg.enable { programs.zellij = { enable = true; }; };

}
