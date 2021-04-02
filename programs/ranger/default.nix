{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      ranger
      ueberzug
    ];

    file.".config/ranger/rc.conf".source = ./rc.conf;
  };
}
