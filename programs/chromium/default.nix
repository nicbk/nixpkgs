{ config, pkgs, ... }:

{
  imports = [
    ./chromium.nix
  ];

  programs.ungoogled-chromium-custom = {
    enable = true;
    extensions = [
      {
        id = "ogfcmafjalglgifnmanfmnieipoejdcf";
        crxPath = "${config.xdg.dataHome}/chromium/extensions/uMatrix.crx";
        version = "1.4.0";
      }
      {
        id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";
        crxPath = "${config.xdg.dataHome}/chromium/extensions/DarkReader.crx";
        version = "4.9.26";
      }
      {
        id = "dbepggeogbaibhgnhhndojpepiihcmeb";
        crxPath = "${config.xdg.dataHome}/chromium/extensions/Vimium.crx";
        version = "1.66";
      }
    ];
  };
}
