{ pkgs, ... }:

let
  moka-icon-theme = (import ./moka-icon-theme.nix pkgs).moka-icon-theme;
in
{
  gtk = {
    enable = true;
    theme.package = pkgs.arc-theme;
    theme.name = "Arc-Dark";
# TODO Fix custom moka-icon-theme
#    iconTheme.package = pkgs.arc-icon-theme.override {
#      moka-icon-theme = moka-icon-theme;
#    };
    iconTheme.package = pkgs.arc-icon-theme;
    iconTheme.name = "Arc";
    gtk2.extraConfig = ''
      gtk-cursor-theme-size = 18;
    '';
    gtk3.extraConfig = {
      gtk-cursor-theme-size = 18;
    };
  };
}
