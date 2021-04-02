# NixOS Configuration
* [System Configuration](#system-configuration)
* [Home Manager](#home-manager)
* [Private Configuration](#private-configuration)
* [Setup](#setup)

This configuration is intended for a single user system, and is currently running on a
Thinkpad X1 Carbon 7th Generation.

## System Configuration
The `configuration.nix` file is located in `system`.
However, only a small amount of configuration is written system wide.
[Home Manager](#home-manager) is used for defining the environment for users.

## Home Manager
The codebase should be easy to read, with its root at `home.nix`.

## Private Configuration
Private configuration options are located in `$XDG_CONFIG_DIR/private`.
An example of `$XDG_CONFIG_DIR/private/default.nix` is located at `examples/private/default.nix`.

I also keep private data such as SSH keys in `$XDG_DATA_DIR/private`.

## Setup
A `home-manager` channel should be imperatively configured for the single user.
`nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager`
would load the channel for unstable Nix.

`$XDG_CONFIG_DIR/nixpkgs/system/configuration.nix` is hardlinked to `/etc/nixos/configuration.nix`.

`$XDG_CONFIG_DIR/private` is symlinked to `/etc/nixos/private`.

`$XDG_CONFIG_DIR/nixpkgs/misc/handle-monitors` is symlinked to `/etc/nixos/handle-monitors`.
