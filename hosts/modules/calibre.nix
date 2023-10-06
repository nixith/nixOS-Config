{pkgs, ...}: {
  services.calibre-web = {
    enable = true;
    options = {
      calibreLibrary = /home/ryan/CalibreLibrary;
      enableKepubify = true;
      enableBookUploading = true;
    };
  };
  #services.calibre-server = {
  #  enable = true;
  #};
}
