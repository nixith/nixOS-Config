{ self, super, ... }:
{
  xournalpp = super.xournalpp.overrideAttrs (old: {
    # Override src with the version you want
    src = super.fetchFromGitHub {
      owner = "xournalpp";
      repo = "xournalpp";

      # Replace with the tag or commit hash you want
      rev = "v1.1.1";

      # Find the sha256 with:
      #   nix-prefetch-url --unpack --type sha256 <url of github tar gz>
      #
      # Example for 1.1.1:
      #   nix-prefetch-url --unpack --type sha256 https://github.com/xournalpp/xournalpp/archive/v1.1.1.tar.gz
      sha256 = "16pf50x1ps8dcynnvw5lz7ggl0jg7qvzv6gkd30xg3hkcxff8ch3";
    };
  });
}
