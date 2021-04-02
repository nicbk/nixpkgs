{ stdenv
, bash
, gnugrep
, sudo
, xrandr
, xmonad-with-packages
, cpupower
, userHome
}:

stdenv.mkDerivation rec {
  name = "handle-monitors";
  src = ./handle-monitors.sh;
  buildInputs = [
    bash
    gnugrep
    sudo
    xrandr
    xmonad-with-packages
    cpupower
  ];
  phases = [ "installPhase" ];
  installPhase = ''
    echo '#!${bash}/bin/bash' > buildVar
    echo 'export XAUTHORITY=${userHome}/.Xauthority' >> buildVar
    echo 'export PATH=$PATH:${gnugrep}/bin' >> buildVar
    echo 'export PATH=$PATH:${sudo}/bin' >> buildVar
    echo 'export PATH=$PATH:${xrandr}/bin' >> buildVar
    echo 'export PATH=$PATH:${xmonad-with-packages}/bin' >> buildVar
    echo 'export PATH=$PATH:${cpupower}/bin' >> buildVar
    cat buildVar $src > $out
    chmod 755 $out
  '';
}
