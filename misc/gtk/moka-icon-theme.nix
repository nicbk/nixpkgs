{ pkgs, ... }:

pkgs.moka-icon-theme.overrideAttrs (oldAttrs: rec {
  version = "custom";
  src = pkgs.fetchFromGitHub {
    owner = "nicbk";
    repo = oldAttrs.pname;
    rev = "0a2c032115b057bac3d3728ac931a0fa62dc2b31";
    sha256 = "1n71zlvy37bmr4xi3g1lgs5p5hx3qqna4ziriqwhbhq882p0v5kz";
  };
})
