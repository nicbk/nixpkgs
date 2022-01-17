{ config, pkgs, lib }:

with lib;
let
  cfg = config.services.xserver;
  fontsForXServer =
    config.fonts.fonts ++
    [ pkgs.xorg.fontadobe100dpi
      pkgs.xorg.fontadobe75dpi
    ];
xorg-conf-std = pkgs.runCommand "xorg-conf-std"
{ fontPath = optionalString (cfg.fontPath != false)
    ''FontPath "${toString cfg.fontPath}"'';
  inherit (cfg) config;
  preferLocalBuild = true;
}
  ''
    echo 'Section "Files"' >> $out
    echo $fontPath >> $out
    for i in ${toString fontsForXServer}; do
      if test "''${i:0:''${#NIX_STORE}}" == "$NIX_STORE"; then
        for j in $(find $i -name fonts.dir); do
          echo "  FontPath \"$(dirname $j)\"" >> $out
        done
      fi
    done
    for i in $(find ${toString cfg.modules} -type d); do
      if test $(echo $i/*.so* | wc -w) -ne 0; then
        echo "  ModulePath \"$i\"" >> $out
      fi
    done
    echo 'EndSection' >> $out
    echo "$config" >> $out
    sed -i '/Screen "Screen-nvidia\[0\]"/d' $out
    sed -i 's/Inactive "Device-modesetting\[0\]"/Screen "Screen-modesetting\[0\]"/g' $out
  '';
in
pkgs.writeShellScriptBin "startx-std" ''
  ${pkgs.xorg.xinit}/bin/startx -- -config ${xorg-conf-std}
''
