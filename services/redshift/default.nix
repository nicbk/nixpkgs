{ pkgs, ... }:

{
  services.redshift = {
    enable = true;
    latitude = "37";
    longitude = "-121";
    settings = {
      redshift = {
        brightness-day = "1";
        brightness-night = "0.6";
      };
    };
  }; 
}
