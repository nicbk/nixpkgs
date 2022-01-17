{ pkgs, ... }:

let
  upgrade = pkgs.writeShellScriptBin "upgrade" (builtins.readFile ./upgrade.sh);
  backup = pkgs.writeShellScriptBin "main_backup" "
  #!/bin/sh
  ~/Documents/Software/System/Backup/backup.sh
  ";
  zfsAttach = pkgs.writeShellScriptBin "zfs_attach" "
  #!/bin/sh
  ~/Documents/Software/System/Backup/zfs_attach.sh
  ";
  zfsDetach = pkgs.writeShellScriptBin "zfs_detach" "
  #!/bin/sh
  ~/Documents/Software/System/Backup/zfs_detach.sh
  ";
in
{
  home.packages = with pkgs; [
    upgrade
    backup
    zfsAttach
    zfsDetach
  ];
}
