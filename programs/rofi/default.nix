{ pkgs, ... }:

let
  st = import ../st/st.nix pkgs;
in
{
  programs.rofi = {
    enable = true;
    pass = {
      enable = true;
      extraConfig = ''
        default_do='copyPass'
      '';
    };
    terminal = "${st}/bin/st";
    theme = ./arthur.rasi;
  };
}
