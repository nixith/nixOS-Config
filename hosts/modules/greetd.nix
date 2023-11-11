{pkgs, ...}: {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time  \ 
        --cmd Hyprland \
        --greeting 'Trans Rights' \
        --remember \
        --remember-session
        --user-menu";
        user = "greeter";
      };
    };
  };
}
