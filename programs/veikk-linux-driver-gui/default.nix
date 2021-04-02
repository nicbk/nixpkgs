{ pkgs, ... }:

let
  veikk-linux-driver-gui = pkgs.callPackage (import ./veikk-linux-driver-gui.nix) {
    mkDerivation = pkgs.qt5.mkDerivation;
    qmake = pkgs.qt5.qmake;
  };
in
{
  home.packages = [ veikk-linux-driver-gui ];
}
