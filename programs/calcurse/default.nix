{ pkgs, ... }:

{
  home = {
    packages = [ pkgs.calcurse ];
    file = {
      ".config/calcurse/conf".source = ./conf;
      ".config/calcurse/keys".source = ./keys;
    };
  };
}
