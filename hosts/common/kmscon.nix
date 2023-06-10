{pkgs, ...}: {
  services.kmscon = {
    enable = true;
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
