{ config, lib, pkgs, ... }:

let
  oauth2l = pkgs.callPackage (import ./oauth2l.nix) {  };
  sasl2-oauth = pkgs.callPackage (import ./sasl2-oauth.nix) {
    mkDerivation = pkgs.stdenv.mkDerivation;
  };
  cyrus_sasl = pkgs.cyrus_sasl.overrideAttrs (div: rec {
    postInstall = ''
      for lib in ${sasl2-oauth}/lib/sasl2/*; do
        ln -sf $lib $out/lib/sasl2/
      done
    '';
  });
  isync = pkgs.isync.override {
    cyrus_sasl = cyrus_sasl;
  };
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
      isync # EMail MTA for imap
#      oauth2l # Retrieve OAuth2 Token
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
        ".mbsyncrc".source = private-dir + "/mbsyncrc";
        ".notmuch-config".source = private-dir + "/notmuch-config";
      }
      private-config.neomutt.accounts
    ];
  };
}
