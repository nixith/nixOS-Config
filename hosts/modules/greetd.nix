{ pkgs, ... }: {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time "
          + "--cmd 'niri-session' " + "--greeting 'Trans Rights' "
          + "--remember " + "--remember-session " + "--user-menu";
        user = "greeter";
      };
    };
  };
  # programs.regreet = {
  #   enable = true;
  # };
}
