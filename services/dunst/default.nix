{ config, pkgs, ... }:

{
  home.packages = [ pkgs.libnotify ];
  services.dunst = {
    enable = true;
    settings = {
      global = {
        follow = "keyboard";
        geometry = "600x8-45+45";
        transparency = 5;
        frame_color = "#808080";
        frame_width = 2;
        separator_height = 2;
        separator_color = "#808080";
        font = "Liberation Mono 18";
        format = "<b>%s</b>\\n%b";
      };

      urgency_low = {
        background = "#303030";
        foreground = "#999999";
        timeout = 10;
      };

      urgency_normal = {
        background = "#303030";
        foreground = "#eeeeee";
        timeout = 10;
      };

      urgency_critical = {
        background = "#303030";
        foreground = "#ee1010";
        timeout = 20;
      };
    };
  };
}
