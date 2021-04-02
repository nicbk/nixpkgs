{ config, pkgs, ... }:

let
  private-config = import ../../../private/default.nix {
    config = config;
  };
in
{
  programs.password-store = {
    enable = true;
    settings = private-config.password-store.settings;
  };
}
