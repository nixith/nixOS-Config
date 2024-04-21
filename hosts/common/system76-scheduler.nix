{ pkgs, config, ... }: {
  services.system76-scheduler = {
    enable = true;
    useStockConfig = true;
    settings = {
      processScheduler = {
        pipewireBoost.enable = true;
        foregroundBoost = true;
      };
      cfsProfiles.enable = true;
    };
  };
}
