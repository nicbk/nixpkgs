{ pkgs, ... }:

pkgs.st.overrideAttrs (oldAttrs: rec {
  version = "0.8.4";
  patches = [ ./st.diff ];
  buildInputs = with pkgs.xorg; [ libX11 libXft libXcursor ];
  src = pkgs.fetchurl {
    url = "https://dl.suckless.org/st/${oldAttrs.pname}-${version}.tar.gz";
    sha256 = "19j66fhckihbg30ypngvqc9bcva47mp379ch5vinasjdxgn3qbfl";
  };
  configFile = pkgs.writeText "config.def.h" (builtins.readFile ./config.h);
  postPatch = "${oldAttrs.postPatch}\n cp ${configFile} config.def.h";
})
