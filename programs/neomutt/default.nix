{ config, lib, pkgs, ... }:

let
  private-config = import ./../../../private {
    config = config;
  };
  private-dir = ./../../../private;
in
{
  home = {
    packages = with pkgs; [
      neomutt # EMail client
      mpop # EMail MTA (Receive Only)
      msmtp # EMail MTA (Transmit Only)
      maildrop # EMail MDA
      notmuch # Indexer
      urlview # Open links
      curl # Download
      pass # Store password with GPG Encryption
      w3m # Show HTML
    ];
    file = lib.mkMerge [
      {
        ".mailcap".source = ./share/mailcap;
        ".config/neomutt/share/global.neomuttrc".source = ./share/neomuttrc;
        ".config/neomutt/neomuttrc".source = private-dir + "/neomutt/selector.neomuttrc";
        ".config/msmtp/config".source = private-dir + "/msmtp/config";
        ".config/mpop/config".source = private-dir + "/mpop/config";
        ".notmuch-config".source = private-dir + "/notmuch-config";
      }
      private-config.neomutt.accounts
    ];
  };
}
