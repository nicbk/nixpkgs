{
  lib,
  mkDerivation,
  fetchFromGitHub,
  gnumake,
  qmake
}:

mkDerivation rec {
  name = "veikk-linux-driver-gui";
  version = "v2.0";

  src = fetchFromGitHub {
    owner = "jlam55555";
    repo = name;
    rev = version;
    sha256 = "02g1q79kwjlzg95w38a1d7nxvcry8xcsvhax2js4c7xqvzhkki5j";
  };

  nativeBuildInputs = [ qmake gnumake ];

  buildPhase = ''
    qmake
    make all clean
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp veikk-linux-driver-gui $out/bin
  '';

  meta = with lib; {
    description = "VEIKK Drawing Tablet GUI";
    maintainers = [ "Nicolás Kennedy <nicolas@nicbk.com>" ];
    platforms = platforms.linux;
    homepage = "https://github.com/jlam55555/veikk-linux-driver-gui/";
  };
}
