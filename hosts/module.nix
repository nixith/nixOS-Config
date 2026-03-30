{ lib, ... }:
let
in
{
  options = {
    nixith.user = lib.mkOption {
      default = "alice";
      type = lib.types.str;
    };
  };

  # configless module
}
