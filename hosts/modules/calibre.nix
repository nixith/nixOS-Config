{config, ...}: {
  services.calibre-web = {
    enable = true;
    listen = {
      ip = "0.0.0.0";
    };
    options = {
      calibreLibrary = /home/ryan/CalibreLibrary;
      enableKepubify = true;
      enableBookUploading = true;
    };
  };
  services.calibre-server = {
    enable = true;
    user = "ryan";
    libraries = [
      /home/ryan/CalibreLibrary
    ];
  };
}
