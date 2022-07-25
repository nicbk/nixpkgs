{ pkgs, ... }:

let
  xsetwacom_pressure = pkgs.writeShellScriptBin "xsetwacom_pressure"
    "xsetwacom set \"Wacom One by Wacom M Pen stylus\" PressureCurve 0 23 56 85";
  xsetwacom_monitor = pkgs.writeShellScriptBin "xsetwacom_monitor" "
    xsetwacom set \"Wacom One by Wacom M Pen stylus\" MapToOutput $@
    xsetwacom set \"Wacom One by Wacom M Pen eraser\" MapToOutput $@
  ";
in
{
  home.packages = [
    xsetwacom_pressure
    xsetwacom_monitor
  ];
}
