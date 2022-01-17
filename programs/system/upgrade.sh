#!/bin/sh
set -e
sudo journalctl --rotate
sudo journalctl --vacuum-size=50M
sudo nixos-rebuild boot --upgrade
nix-channel --update home-manager
home-manager switch
rm -f ~/.xmonad/xmonad-x86_64-linux
rm -f ~/.cache/taffybar/taffybar-linux-x86_64
nix-collect-garbage -d
home-manager expire-generations "-5 days"
