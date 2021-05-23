{ config, pkgs, ... }:

let
  private-config = import ./../private {
    config = config;
  };
in
{
  imports = [
    ./misc/gtk
    ./programs/bash
    ./programs/calcurse
    ./programs/chromium
    ./programs/git
    ./programs/gpg
    ./programs/neomutt
    ./programs/neovim
    ./programs/password-store
    ./programs/ranger
    ./programs/rofi
    ./programs/ssh
    ./programs/st
    ./programs/startx
    ./programs/veikk-linux-driver-gui
    ./programs/weechat
    ./programs/xournalpp
    ./programs/zathura
    ./services/dunst
    ./services/gpg-agent
    ./services/picom
    ./services/redshift
    ./services/status-notifier-watcher
    ./services/taffybar
    ./services/tor
    ./services/wm/xmonad
  ];

  home = {
    packages = with pkgs; [
      nerdfonts
      glxinfo
      lshw
      htop
      pavucontrol
      unzip
      killall
      usbutils
      pciutils
      xclip
      imagemagick
      inkscape
      gimp
      scrot
      blender
      texlive.combined.scheme-full
      rtv
      tor-browser-bundle-bin
      multimc
      python3
      guile
      ghc
      gcc
      rustup
      qemu
      mpv
      element-desktop
      zoom-us
      logisim
      eclipses.eclipse-java
    ];

    stateVersion = "21.03";
    username = private-config.userName;
    homeDirectory = private-config.userHome;
  };

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
}
