{ _ }:
{
  services.suwayomi-server = {
    enable = true;
    systemTrayEnabled = true;
    extensionRepos = [ "https://github.com/keiyoushi/extensions/blob/repo/index.min.json" ];
    downloadAsCbz = true;
  };
}
