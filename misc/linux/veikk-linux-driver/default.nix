{ stdenv, fetchFromGitHub, kernel }:

stdenv.mkDerivation rec {
  pname = "veikk-linux-driver";
  version = "v2.0";

  src = fetchFromGitHub {
    owner = "jlam55555";
    repo = pname;
    rev = version;
    sha256 = "11mg74ds58jwvdmi3i7c4chxs6v9g09r9ll22pc2kbxjdnrp8zrn";
  };

  nativeBuildInputs = kernel.moduleBuildDependencies;

  buildInputs = [ kernel ];

  buildPhase = ''
    make BUILD_DIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build
  '';

  installPhase = ''
    mkdir -p $out/lib/modules/${kernel.modDirVersion}/kernel/drivers/veikk
    install -Dm755 veikk.ko $out/lib/modules/${kernel.modDirVersion}/kernel/drivers/veikk
  '';

  meta = with stdenv.lib; {
    description = "VEIKK drawing tablet driver";
    maintainers = [ "Nicolás Kennedy <nicolas@nicbk.com>" ];
    platforms = platforms.linux;
    homepage = "https://github.com/jlam55555/veikk-linux-driver/";
  };
}
