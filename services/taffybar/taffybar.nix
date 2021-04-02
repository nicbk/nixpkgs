{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.taffybar-custom;
  taffybar = pkgs.taffybar.override {
    ghcWithPackages = cfg.haskellPackages.ghcWithPackages;
    packages = self:
      cfg.extraPackages self;
  };
in {
  meta.maintainers = [ maintainers.rycee ];

  options.services.taffybar-custom = {
    enable = mkEnableOption "Taffybar";

    config = mkOption {
      type = types.nullOr types.path;
      default = null;
      description = "Configuration file for Taffybar";
    };

    css = mkOption {
      type = types.nullOr types.path;
      default = null;
      description = "CSS Configuration file for Taffybar";
    };

    package = mkOption {
      default = taffybar;
      defaultText = literalExample "taffybar";
      type = types.package;
      example = literalExample "pkgs.taffybar";
      description = "The package to use for the Taffybar binary.";
    };

    haskellPackages = mkOption {
      default = pkgs.haskellPackages;
      defaultText = literalExample "pkgs.haskellPackages";
      example = literalExample "pkgs.haskell.packages.ghc784";
      description = ''
        The <varname>haskellPackages</varname> used to build taffybar
        and other packages. This can be used to change the GHC
        version used to build taffybar and the packages listed in
        <varname>extraPackages</varname>.
      '';
    };

    extraPackages = mkOption {
      default = self: [  ];
      defaultText = "self: []";
      example = literalExample ''
        haskellPackages: [
          haskellPackages.xmonad-contrib
          haskellPackages.monad-logger
        ]
      '';
      description = ''
        Extra packages available to GHC when rebuilding taffybar. The
        value must be a function which receives the attribute set
        defined in <varname>haskellPackages</varname> as the sole
        argument.
      '';
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      home.packages = with pkgs; [ dconf ];
       
      systemd.user.services.taffybar = {
        Unit = {
          Description = "Taffybar desktop bar";
          After = [ "graphical-session-pre.target" ];
          PartOf = [ "graphical-session.target" ];
          Requires = [ "status-notifier-watcher.service" "dbus.socket" ];
        };

        Service = {
          ExecStart = "${cfg.package}/bin/taffybar";
          Restart = "on-failure";
        };

        Install = { WantedBy = [ "graphical-session.target" ]; };
      };

      xsession.importedVariables = [ "GDK_PIXBUF_MODULE_FILE" ];
    }

    (mkIf (cfg.config != null) {
      xdg.configFile."taffybar/taffybar.hs".source = cfg.config;
    })

    (mkIf (cfg.css != null) {
      xdg.configFile."taffybar/taffybar.css".source = cfg.css;
    })
  ]);
}
