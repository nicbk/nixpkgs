{ pkgs, ... }:

{
  imports = [
    ./taffybar.nix
  ];

  services.taffybar-custom = {
    enable = true;
    config = ./taffybar.hs;
    css = ./taffybar.css;
  };
}
