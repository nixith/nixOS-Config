{ config, lib, pkgs, ... }:

{
  programs.newsboat = {
    enable = true;
    autoReload = true;
    extraConfig = builtins.readFile (./dark);

    urls = [
      {
        url = "https://nixos.org/blog/announcements-rss.xml";
        title = "NixOS";
      }
      {
        url = "https://itsfoss.com/rss/";
        title = "It's Foss";
      }
      {
        url = "https://9to5linux.com/feed";
        title = "9To5Linux";
      }
      {
        url = "https://www.phoronix.com/rss.php";
        title = "Phoronix";
      }
      {
        url = "http://www.engadget.com/rss.xml";
        title = "Engadget";
      }
      {
        url = "https://www.androidpolice.com/feed";
        title = "Android Police";
      }
      {
        url = "https://www.androidauthority.com/feed";
        title = "Android Authority";
      }
    ];
  };
}
