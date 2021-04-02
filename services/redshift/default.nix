{ pkgs, ... }:

{
  services.redshift = {
    enable = true;
    latitude = "37";
    longitude = "-121";
  }; 
}
