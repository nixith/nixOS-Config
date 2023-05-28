{
  pkgs,
  config,
  ...
}: {
  services.system76-scheduler = {
    enable = true;
    useStockConfig = true;
  };
}
