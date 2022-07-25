{ pkgs, ... }:

{
  gtk = {
    enable = true;
    theme.package = pkgs.whitesur-gtk-theme;
    theme.name = "WhiteSur-dark";
    iconTheme.package = pkgs.whitesur-icon-theme;
    iconTheme.name = "WhiteSur";
    cursorTheme.name = "elementary";
  };
}
