{ config, pkgs, ... }:

let
  private-config = import ./../../../private {
    config = config;
  };
in
{
  imports = [
    ./chromium.nix
  ];

  programs.ungoogled-chromium-custom = {
    enable = true;
    extensions = private-config.chromium.extensions;
  };
}
