{ config, pkgs, ... }:

let
  private-config = import ./../private {
    config = config;
  };
  unstableTarball = fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz;
  unstableNixos = import unstableTarball {};
  unstablePkgs = unstableNixos.pkgs;
in
{
  imports = [
    ./misc/gtk
    ./misc/xdg
    ./programs/bash
    ./programs/calcurse
    ./programs/chromium
    ./programs/fzf
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
    ./programs/tmux
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
      file
      imagemagick
      inkscape
      multimc
      gimp
      scrot
      blender
      texlive.combined.scheme-full
      rtv
      unstablePkgs.tor-browser-bundle-bin
      python3
      guile
      ghc
      gcc
      rustup
      qemu
      mpv
      youtube-dl
      element-desktop
      openvpn
      networkmanager-openvpn
      zoom-us
      gnome3.pomodoro
      logisim
      eclipses.eclipse-java
      jdk
      slack
      krb5
      nfs-utils
      sshfs-fuse
      singularity
    ];

    stateVersion = "21.05";
    username = private-config.userName;
    homeDirectory = private-config.userHome;
  };

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
}
