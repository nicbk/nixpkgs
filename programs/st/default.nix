{ pkgs, ... }:
let
  st = import ./st.nix pkgs;
in
{
  home.packages = [ st ];
}
