{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "Nicolás Kennedy";
    userEmail = "nicolas@nicbk.com";
    signing = {
      key = "nicolas@nicbk.com";
      signByDefault = true;
    };
  };
}
