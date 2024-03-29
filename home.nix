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
    ./programs/alacritty
    ./programs/bash
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
    ./programs/system
    ./programs/tmux
    ./programs/xournalpp
    ./programs/xsetwacom
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
      firefox
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
      gimp
      scrot
      blender
      texlive.combined.scheme-full
      tuir 
      python3
      guile
      ghc
      gcc
      rustup
      qemu
      mpv
      youtube-dl
      torsocks
      openvpn
      networkmanager-openvpn
      networkmanager-openconnect
      networkmanagerapplet
      zoom-us
      weechat
      gnome.pomodoro
      gnome.gnome-calendar
      libreoffice
      gnucash
      logisim
      eclipses.eclipse-java
      slack
      krb5
      nfs-utils
      sshfs-fuse
      singularity
      trash-cli
      rawtherapee
      octaveFull
      qt5ct
      transmission-gtk
      jmtpfs
      lxappearance
      unstablePkgs.jdk
      unstablePkgs.unison-ucm
      unstablePkgs.tor-browser-bundle-bin
      unstablePkgs.polymc
    ];

    stateVersion = "22.05";
    username = private-config.userName;
    homeDirectory = private-config.userHome;
  };

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
}
