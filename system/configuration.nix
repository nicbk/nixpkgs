{ config, pkgs, lib, ... }:

let
  private-config = import ./private {
    config = config;
  };
  configDir = private-config.userHome + "/.config/nixpkgs";
  handle-monitors = pkgs.callPackage (import (configDir + "/misc/handle-monitors")) {
    userHome = private-config.userHome;
    cpupower = pkgs.linuxPackages.cpupower;
  };
  veikk-linux-driver = pkgs.callPackage (import (configDir + "/misc/linux/veikk-linux-driver")) {
    kernel = pkgs.linuxPackages_hardened.kernel;
  };
  nvidia-offload = pkgs.callPackage (import (configDir + "/misc/nvidia-offload")) {};
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
    logind = {
      lidSwitch = "hibernate";
      lidSwitchDocked = "hibernate";
    };
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      useGlamor = true;
      xkbOptions = "altwin:prtsc_rwin,compose:ralt";
      layout = "us";
      displayManager.startx.enable = true;
      windowManager = {
        xmonad.enable = true;
        xmonad.enableContribAndExtras = true;
      };
      libinput.enable = true;
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
    nvidia.prime = {
      sync.allowExternalGpu = true;
      offload.enable = true;
      nvidiaBusId = "PCI:10:0:0";
      intelBusId = "PCI:0:2:0";
    };
    bluetooth.enable = true;
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
    nvidia-offload
    tpacpi-bat
  ];

  systemd.services.lidinit = {
    description = "Disable wake on lid open";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c \"echo LID > /proc/acpi/wakeup\"";
    };
    wantedBy = [ "default.target" ];
  };

  system.stateVersion = "20.09";
}
