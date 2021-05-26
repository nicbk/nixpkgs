{ config, pkgs, lib, ... }:

let
  private-config = import ./private {
    config = config;
  };
  configDir = private-config.userHome + "/.config/nixpkgs";
  startx-std = (import (configDir + "/misc/startx-std")) {
    config = config;
    pkgs = pkgs;
    lib = lib;
  };
  nvidia-kernel-reset = (import (configDir + "/misc/nvidia-kernel-reset")) {
    pkgs = pkgs;
  };
  veikk-linux-driver = pkgs.callPackage (import (configDir + "/misc/linux/veikk-linux-driver")) {
    kernel = pkgs.linuxPackages_hardened.kernel;
  };
in
{
  imports = [
    ./hardware-configuration.nix
  ];

  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 8d";

  boot = {
    kernel.sysctl = {
      "kernel.unprivileged_userns_clone" = 1;
    };
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    supportedFilesystems = [ "zfs" ];
    cleanTmpDir = true;
    initrd.luks.devices = {
      "root" = {
        device = "/dev/disk/by-uuid/" + private-config.luksUuid;
        preLVM = true;
        allowDiscards = true;
      };
    };
    kernelPackages = pkgs.linuxPackages_hardened;
    kernelParams = [
      "lockdown=confidentiality"
      "cpuidle.governor=teo"
      "msr.allow_writes=on"
    ];
    extraModulePackages = with config.boot.kernelPackages; [
      acpi_call
      veikk-linux-driver
    ];
  };

  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];

  networking = {
    firewall.allowedTCPPorts = [ 8000 8080 ];
    hostId = private-config.hostId;
    hostName = private-config.hostName;
    networkmanager = {
      enable = true;
      wifi = {
        macAddress = "random";
        powersave = true;
      };
    };
  };

  time.timeZone = private-config.timeZone;

  networking.useDHCP = false;

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  sound.enable = true;

  programs = {
    light.enable = true;
    steam.enable = true;
  };

  services = {
    gnome3.at-spi2-core.enable = true;
    upower.enable = true;
    hardware.bolt.enable = true;
    tlp.enable = true;
    logind = {
      lidSwitch = "hibernate";
      lidSwitchDocked = "hibernate";
    };
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" "modesetting" ];
      useGlamor = true;
      xkbOptions = "altwin:prtsc_rwin,compose:ralt";
      layout = "us";
      displayManager.startx.enable = true;
      windowManager = {
        xmonad.enable = true;
        xmonad.enableContribAndExtras = true;
      };
      libinput.enable = true;
      config =
      ''
        Section "Monitor"
          Identifier "Monitor[0]"
        EndSection

        Section "ServerLayout"
          Identifier "Layout[all]"
          Screen "Screen-nvidia[0]"
          Inactive "Device-modesetting[0]"
          Option "AllowNVIDIAGPUScreens"
        EndSection

        Section "Device"
          Identifier "Device-modesetting[0]"
          Driver "modesetting"
        EndSection

        Section "Screen"
          Identifier "Screen-modesetting[0]"
          Device "Device-modesetting[0]"
        EndSection

        Section "Device"
          Identifier "Device-nvidia[0]"
          Driver "nvidia"
          Option "AccelMethod" "glamor"
          BusID "PCI:10:0:0"
          Option "AllowExternalGpus"
        EndSection

        Section "Screen"
          Identifier "Screen-nvidia[0]"
          Device "Device-nvidia[0]"
          Option "RandRRotation" "on"
          DefaultDepth    24
          Option         "Stereo" "0"
          Option         "nvidiaXineramaInfoOrder" "DFP-3"
          Option         "metamodes" "DP-2: nvidia-auto-select +0+0, DP-0: nvidia-auto-select +6400+0 {AllowGSYNCCompatible=On}"
          Option         "SLI" "Off"
          Option         "MultiGPU" "Off"
          Option         "BaseMosaic" "off"
          SubSection     "Display"
              Depth       24
          EndSubSection
        EndSection
      '';
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
    };
  };

  hardware = {
    enableAllFirmware = true;
    cpu.intel.updateMicrocode = true;
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };
    bluetooth.enable = true;
    nvidia.prime = {
      offload.enable = true;
      nvidiaBusId = "PCI:10:0:0";
      intelBusId = "PCI:0:2:0";
    };
    opengl = {
      enable = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
  };

  powerManagement.powertop.enable = true;

  users.users.${private-config.userName} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "input"
      "video"
      "render"
      "audio"
      "networkmanager"
    ];
    home = private-config.userHome;
  };

  security.chromiumSuidSandbox.enable = true;

  environment.systemPackages = with pkgs; [
    tpacpi-bat
    startx-std
    nvidia-kernel-reset
  ];

  systemd.services.lidinit = {
    description = "Disable wake on lid open";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c \"echo LID > /proc/acpi/wakeup\"";
    };
    wantedBy = [ "default.target" ];
  };

  systemd.services.disableradio = {
    description = "Disable radio functionality";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c \"${pkgs.utillinux}/bin/rfkill block all\"";
    };
    wantedBy = [ "default.target" ];
  };

  system.stateVersion = "20.09";
}
