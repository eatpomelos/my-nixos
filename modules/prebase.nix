{ pkgs, inputs, userName, ... }:

{
    # grub配置，配置grub主题
  nixpkgs.config.packageOverrides = pkgs: {
    sleek-grub-theme = pkgs.sleek-grub-theme.override {withBanner = "Hello Spikely!";  withStyle = "bigSur"; };
  };

  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
    fontSize = 16;
    theme = "${pkgs.sleek-grub-theme}";
  };
  
  # 为运行bin文件
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc
    ];
  };
  
  # 设置nix镜像保存个数
  boot.loader.systemd-boot.configurationLimit = 15;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 2w";
  };
  
  nix.settings.auto-optimise-store = true;
  
    environment.systemPackages = with pkgs; [
    # linux内核头文件
    linuxHeaders
    
    overskride
    # icon fonts
    material-design-icons
    font-awesome

    # 音频编辑器
    # audacity
    # 图片编辑器，photoshop替代品
    gimp
    
    # usb
    usbutils
    
    xdg-user-dirs-gtk

    # 网络连接前端
    networkmanagerapplet
  ];
  
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";  # enable apps use xwayland, fix for fcitx
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

  environment.variables.EDITOR = "vim";

  networking.extraHosts = 
    ''
    185.199.108.133 raw.githubusercontent.com
    31.209.137.10 bifrost.vivaldi.com
    '';

}
