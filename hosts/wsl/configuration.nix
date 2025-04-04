
{ config, lib, pkgs, ... }:

{
  wsl.enable = true;
  wsl.defaultUser = "nixos";

  # 自定义配置
  # Enable networking
  # networking.networkmanager.enable = true;
  # wsl.wslConf.network.generateHosts = false;

  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;

  # networking.firewall.enable = true;
  # networking.firewall.allowedTCPPorts = [ 22 80 3000 222];
  # networking.firewall.allowedUDPPorts = [ 53 3000 22 222];
  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.
  i18n.defaultLocale = "zh_CN.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "zh_CN.UTF-8";
    LC_IDENTIFICATION = "zh_CN.UTF-8";
    LC_MEASUREMENT = "zh_CN.UTF-8";
    LC_MONETARY = "zh_CN.UTF-8";
    LC_NAME = "zh_CN.UTF-8";
    LC_NUMERIC = "zh_CN.UTF-8";
    LC_PAPER = "zh_CN.UTF-8";
    LC_TELEPHONE = "zh_CN.UTF-8";
    LC_TIME = "zh_CN.UTF-8";
  };

  # 设置nix镜像保存个数
  boot.loader.systemd-boot.configurationLimit = 15;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };
 
  nix.settings.auto-optimise-store = true;
  

  # services.xserver.desktopManager.xfce.enable = true;
  
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    # Configure keymap in X11
    xkb = {
      layout = "cn";
      variant = "";
    };
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # locate
  services.locate = {
    enable = true;
    package = pkgs.mlocate;
    interval = "hourly";
    localuser = null;
  };

  programs.bash = let
    envExtra = ''
        export PATH="$PATH:/home/nixos/spk/code/my_scripts"
    '';
  in {
    completion.enable = true;
    loginShellInit = envExtra;
  };
 
  # 启用 Flakes 特性以及配套的 nix 命令行工具
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    # Flakes 通过 git 命令拉取其依赖项，所以必须先安装好 git
    git
    vim
    wget

    # calc
    gnumake
    # for vterm
    cmake
    libtool
    gcc
    gdb
    cppcheck
    
   # font-awesome

    # home包
    neofetch
    
    # 文泉驿字体，后面的终端以及emacs都会用到
    # wqy_zenhei
    
    # utils	
    jq

    libclang
    clang

    # emacs相关
    # utils
    ripgrep
    fd

    # utils
    curl
    killall
    
    # for mount
    # cifs-utils
    sambaFull
    emacs
    pandoc
    # emacsPackages.lsp-bridge
    # python配置
    pyright
    (python311.withPackages (
        ps:
          with ps; [
            ruff
            black # python formatter
            # debugpy
            pyqt6
            pyqt6-sip
            pyqt6-webengine
            cookies

            # my commonly used python packages
            jupyter
            ipython
            pandas
            requests
            pyquery
            pyyaml
            boto3

            ## emacs's lsp-bridge dependenciesge
            epc
            orjson
            sexpdata
            six
            setuptools
            paramiko
            rapidfuzz
            watchdog
            packaging
            python-lsp-server
          ]
      ))
    # lsp-language-server
    nixd
    basedpyright
    texlab
    lua-language-server
    rust-analyzer
    typescript-language-server
    cmake-language-server
    clojure-lsp
    hyprls

    # perl相关包
    perl540
    perl540Packages.PLS
    perlnavigator
    
    # docker support
    docker-compose
    sdcv
    # eaf dependenciesge
    # pkg-config
    # libinput
    # libevdev
    # libudev-zero
    # sdcv
    # emacs-rime
    # dbus
    fcitx5
    fcitx5-rime
    librime
    rime-data

    # terminal
    tmux
  ];

  fonts.packages = with pkgs; [
    wqy_zenhei
  ];

  #inputmethod
  environment.variables = {
    EDITOR = "vim";
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
  };

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      rime-data
      fcitx5-gtk
      fcitx5-rime
    ];
  };

  # docker config
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      # enables pulling using containerd, which supports restarting from a partial pull
      # https://docs.docker.com/storage/containerd/
      "features" = {"containerd-snapshotter" = true;};
    };
    
    # start dockerd on boot.
    # This is required for containers which are created with the `--restart=always` flag to work.
    enableOnBoot = true;
  };
  
  # 配置fzf
  programs.fzf = {
    fuzzyCompletion = true;
    keybindings = true;
  };

  networking.extraHosts = 
    ''
    185.199.108.133 raw.githubusercontent.com
    31.209.137.10 bifrost.vivaldi.com
    '';

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
