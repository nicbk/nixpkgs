{
  lib,
  mkDerivation,
  fetchFromGitHub,
  pkgconfig,
  autoconf,
  automake,
  cyrus_sasl,
  gnumake,
  libtool
}:

mkDerivation rec {
  name = "sasl2-oauth";
  version = "4236b6f";

  src = fetchFromGitHub {
    owner = "robn";
    repo = name;
    rev = "4236b6fb904d836b85b55ba32128b843fd8c2362";
    sha256 = "17c1131yy41smz86fkb6rywfqv3hpn0inqk179a4jcr1snsgr891";
  };

  buildInputs = [
    pkgconfig
    autoconf
    automake
    cyrus_sasl
    gnumake
    libtool
  ];

  configurePhase = ''
    libtoolize
    install -d m4
    aclocal -I m4
    autoheader
    automake -c -a --foreign
    autoconf
    ./configure --prefix=$out
  '';

  buildPhase = ''
    make
  '';

  installPhase = ''
    make install
  '';
}
