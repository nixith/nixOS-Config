# This is my NixOS configuration

# How this is split up

## hardware configuration

in config.nix, we define how hardware is supposed to work.
`/modules` holds our odd hardware configuration options, and we have a base configuration.
This base configuration should be copied to a file for the machine, then symlinekd to configuation.nix

for a detailed process:

1. Clone repo
2. copy BaseConfig to configuration.nix
3. add other hardware modules to imports
