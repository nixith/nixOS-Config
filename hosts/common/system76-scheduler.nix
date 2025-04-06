{ ... }:
{
  services.system76-scheduler = {
    enable = true;
    useStockConfig = true;
    assignments = {
      nix-builds = {
        nice = 15;
        class = "batch";
        ioClass = "idle";
        matchers = [ "nix-daemon" ];
      };
    };
  };
}
