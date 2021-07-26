{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    clock24 = true;
  };
}
