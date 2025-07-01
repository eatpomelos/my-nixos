{
  pkgs,
  config,
  lib,
  ...
}: {
  # 开启英伟达显卡驱动
  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  # boot.kernelPackages = pkgs.linuxKernel.packages.linux_5_10;
  # boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_6;
  # boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_1;
 
  # 关闭开源驱动
  boot.extraModprobeConfig = ''
   blacklist nouveau
   options nouveau modeset=0
   '';
  
  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = true;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Dynamic Boost. It is a technology found in NVIDIA Max-Q design laptops with RTX GPUs.
    # It intelligently and automatically shifts power between
    # the CPU and GPU in real-time based on the workload of your game or application.
    #dynamicBoost.enable = lib.mkForce true;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;
    
    # nvidiaPersistenced = true;
    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    # package = config.boot.kernelPackages.nvidiaPackages.beta;
    # package = config.boot.kernelPackages.nvidiaPackages.production;
    package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;
    
    # package = let 
    #   rcu_patch = pkgs.fetchpatch {
    #     url = "https://github.com/gentoo/gentoo/raw/c64caf53/x11-drivers/nvidia-drivers/files/nvidia-drivers-470.223.02-gpl-pfn_valid.patch";
    #     hash = "sha256-eZiQQp2S/asE7MfGvfe6dA/kdCvek9SYa/FFGp24dVg=";
    #   };
    # in config.boot.kernelPackages.nvidiaPackages.mkDriver {
    #   version = "550.107.02";
    #   sha256_64bit = "sha256-+XwcpN8wYCjYjHrtYx+oBhtVxXxMI02FO1ddjM5sAWg=";
    #   sha256_aarch64 = "sha256-mVEeFWHOFyhl3TGx1xy5EhnIS/nRMooQ3+LdyGe69TQ=";
    #   openSha256 = "sha256-Po+pASZdBaNDeu5h8sgYgP9YyFAm9ywf/8iyyAaLm+w=";
    #   settingsSha256 = "sha256-WFZhQZB6zL9d5MUChl2kCKQ1q9SgD0JlP4CMXEwp2jE=";
    #   persistencedSha256 = "sha256-Vz33gNYapQ4++hMqH3zBB4MyjxLxwasvLzUJsCcyY4k=";
      
    #   patches = [ rcu_patch ];
    # };
    # package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;
    # Nvidia Optimus PRIME. It is a technology developed by Nvidia to optimize
    # the power consumption and performance of laptops equipped with their GPUs.
    # It seamlessly switches between the integrated graphics,
    # usually from Intel, for lightweight tasks to save power,
    # and the discrete Nvidia GPU for performance-intensive tasks.
    # prime = {
    #   sync.enable = true;
    #   offload = {
    #     enable = false;
    #     enableOffloadCmd = false;
    #   };

    #   # FIXME: Change the following values to the correct Bus ID values for your system!
    #   # More on "https://wiki.nixos.org/wiki/Nvidia#Configuring_Optimus_PRIME:_Bus_ID_Values_(Mandatory)"
    #   intelBusId = "PCI:0:2:0";
    #   nvidiaBusId = "PCI:1:0:0";
    #   # amdgpuBusId = "PCI:9:0:0";
    # };
  };

  # 使启动菜单中多一个 nvidia-offload 选项，开启offload模式
  # specialisation = {
  #   on-the-go.configuration = {
  #     system.nixos.tags = [ "nvidia-offload" ];
  #     hardware.nvidia = {
  #       prime.offload.enable = lib.mkForce true;
  #       prime.offload.enableOffloadCmd = lib.mkForce true;
  #       prime.sync.enable = lib.mkForce false;
  #       powerManagement.finegrained = lib.mkForce true;
  #     };
  #   };
  # };
  
  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-compute-runtime
      intel-media-driver    # LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver    # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
      mesa
      nvidia-vaapi-driver
      nv-codec-headers-12
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      intel-media-driver
      intel-vaapi-driver
      vaapiVdpau
      mesa
      libvdpau-va-gl
    ];
  };
}
