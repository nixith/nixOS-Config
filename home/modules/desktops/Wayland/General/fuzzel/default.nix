{ pkgs, config, lib, ... }:
let cfg = config.nixith.fuzzel;
in {

  options.nixith.fuzzel = { enable = lib.mkEnableOption "enable fuzzel"; };
  config = lib.mkIf cfg.enable {
    programs.fuzzel = {
      enable = true;

      #TODO: setup math mode
      # settings = {
      #   main = {
      #   };
      # };

    };
  };

}
