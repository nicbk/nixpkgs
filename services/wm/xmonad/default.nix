{ config, pkgs, ... }:

{
  xresources.properties = {
    "Xcursor.size" = 18;
    "Xft.dpi" = 96;
  };

  home = {
    packages = [ pkgs.feh ]; 
    file.".xmonad/background".source = "${config.xdg.dataHome}/backgrounds/background";
  };

  xsession = {
    enable = true;

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      config = ./xmonad.hs;
    };
  };
}
