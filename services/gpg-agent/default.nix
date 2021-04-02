{ config, pkgs, ... }:

let
  private-config = import ../../../private/default.nix {
    config = config;
  };
in
{
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    sshKeys = private-config.gpg-agent.sshKeys;
    defaultCacheTtl = 300;
  };
}
