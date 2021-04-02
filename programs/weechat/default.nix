{ pkgs, ... }:

let
  weechatWithScripts = pkgs.weechat.override {
    configure = { availablePlugins, ... }: {
      scripts = with pkgs.weechatScripts; [
        weechat-otr
      ];
    };
  };
in
{
  home.packages = [ weechatWithScripts ];
}
