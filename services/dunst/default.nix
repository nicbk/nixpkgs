{ config, pkgs, ... }:

{
  home.packages = [ pkgs.libnotify ];
  services.dunst = {
    enable = true;
    settings = {
      global = {
        follow = "keyboard";
        geometry = "600x8-45+60";
        transparency = 25;
        frame_color = "#303030";
        frame_width = 1;
        separator_height = 1;
        separator_color = "#808080";
        padding = 10;
        horizontal_padding = 15;
        font = "DejaVuSansMono Nerd Font 18";
        format = "<b>%s</b>\\n%b";
      };

      urgency_low = {
        background = "#000000";
        foreground = "#999999";
        timeout = 10;
      };

      urgency_normal = {
        background = "#000000";
        foreground = "#eeeeee";
        timeout = 10;
      };

      urgency_critical = {
        background = "#000000";
        foreground = "#ee1010";
        timeout = 20;
      };
    };
  };
}
