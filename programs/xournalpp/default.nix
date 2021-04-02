{ pkgs, ... }:

{
  home = {
    packages = [ pkgs.xournalpp ];
    file.".xournalpp/settings.xml".source = ./settings.xml;
  };
}
