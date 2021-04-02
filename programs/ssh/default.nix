{ pkgs, ... }:

{
  programs.ssh = {
    enable = true;
    extraConfig = builtins.readFile ../../../private/sshconfig;
  };
}
