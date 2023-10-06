{pkgs, ...}: {
  services.calibre-web = {
    enable = true;
    enableBookUpdating = true;
    options = {
      calibreLibrary = /home/ryan + "Calibre Library";
      enableKepubify = true;
    };
  };
  #services.calibre-server = {
  #  enable = true;
  #};
}
