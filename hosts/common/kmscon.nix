{pkgs, ...}: {
  services.kmscon = {
    enable = true;
    extraConfig = "drm=off";
    hwRender = false;
    fonts = [
      {
        name = "Inconsolata";
        package = pkgs.inconsolata-nerdfont;
      }
    ];
  };

  services.gpm = {
    enable = true;
  };
}
