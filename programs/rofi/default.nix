{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    pass = {
      enable = true;
      extraConfig = ''
        default_do='copyPass'
      '';
    };
    terminal = "${pkgs.alacritty}/bin/alacritty";
    theme = ./arthur.rasi;
    extraConfig = {
      matching = "fuzzy";
    };
  };
}
