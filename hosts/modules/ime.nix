{ pkgs, ... }:
{
  i18n.inputMethod = {
    type = "ibus";
    ibus = {
      waylandFrontend = true;
      engines = "typing-booster";
    };
  };
}
