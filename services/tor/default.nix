{ pkgs, ... }:

{
  home.packages = [ pkgs.tor ];
  home.file.".config/torrc".source = ./../../../private/torrc;
}
