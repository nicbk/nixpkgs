{ config, pkgs, ... }:

let
  private-config = import ../../../../private/default.nix {
    config = config;
  };

  handle-monitors = pkgs.callPackage (import ./../../../misc/handle-monitors/default.nix) {
    userHome = private-config.userHome;
    cpupower = pkgs.linuxPackages.cpupower;
  };
in
{
  xresources.properties = {
    "Xcursor.size" = 18;
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
      config = pkgs.writeText "xmonadNew.hs" (
        (builtins.readFile ./xmonad.hs) + "\nhandleMonitors = \"${handle-monitors}\""
      );
    };
  };
}
