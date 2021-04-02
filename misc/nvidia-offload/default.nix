{ pkgs }:

pkgs.writeShellScriptBin "nvidia-offload" ''
  export __NV_PRIME_RENDER_OFFLOAD=1
  export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
  export __GLX_VENDOR_LIBRARY_NAME=nvidia
  export __VK_LAYER_NV_optimus=NVIDIA_only
  export LIBVA_DRIVER_NAME=vdpau
  export VDPAU_DRIVER=nvidia
  exec -a "$0" "$@"
''
