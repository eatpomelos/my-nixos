
{ config, lib, pkgs, ... }:

{
  imports = [
    # include NixOS-WSL modules
    <nixos-wsl/modules>
  ];

  wsl.enable = true;
  wsl.defaultUser = "nixos";

  # 自定义配置
  # Enable networking
  networking.networkmanager.enable = true;

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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

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
  
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "cn";
    variant = "";
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

  # programs.git = {
	# 	enable = true;
	# 	userName = "spikely";
	# 	userEmail = "spikeluoyu@outlook.com";
	# };
	
	# programs.bash = {
	# 	enable = true;
	# 	enableCompletion = true;
	# };
  
  # 启用 starship，这是一个漂亮的 shell 提示符
  # programs.starship = {
  #   enable = true;
  #   # 自定义配置
  #   settings = {
  #     add_newline = false;
  #     aws.disabled = true;
  #     gcloud.disabled = true;
  #     line_break.disabled = true;
  #   };
  # };
 
  # 启用 Flakes 特性以及配套的船新 nix 命令行工具
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    # Flakes 通过 git 命令拉取其依赖项，所以必须先安装好 git
    git
    vim
    wget

    gnumake
    gcc
    
    overskride
    # icon fonts
    material-design-icons
    font-awesome

    # home包
		neofetch
    
    # 文泉驿字体，后面的终端以及emacs都会用到
    wqy_zenhei
    
    # utils	
		jq

    libclang
    clang

    # emacs相关
    		# utils	
		ripgrep
		fd
		emacs
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
    # basedpyright
    texlab
    lua-language-server
    # rust-analyzer
    # typescript-language-server
    cmake-language-server
    # bash-language-server
    # clojure-lsp
    # hyprls
    
    # perl相关包
    # perl540
    # perl540Packages.PLS
    # perlnavigator
    
    # eaf dependenciesge
    # pkg-config
    # libinput
    # libevdev
    # libudev-zero

    # sdcv

  ];
  # 将默认编辑器设置为 vim
  environment.variables.EDITOR = "vim";

  # 配置fzf
  # programs.fzf = {
  #   enable = true;
  #   package = pkgs.fzf;
  #   enableBashIntegration = true;
  #   changeDirWidgetCommand = "fd --type d";
  #   changeDirWidgetOptions = [
  #     "--preview 'tree -C {} | head -200'"
  #   ];
  #   defaultCommand = "fd --type f";
  #   defaultOptions = [
  #     "--height 40%"
  #     "--border"
  #   ];
  #   fileWidgetCommand = "fd --type f";
  #   fileWidgetOptions = [ "--preview 'head {}'" ];
  #   historyWidgetOptions = [
  #     "--sort"
  #     "--exact"
  #   ];
  # };

  # programs.kitty = {
  #   enable = true;
  #   # font.name = "Dejavu Sans";
  #   # font.size = 10;
  #   keybindings = {
  #     "ctrl+c" = "copy_or_interrupt";
  #   };
  #   settings = {
  #     scrollback_lines = 100000;
  #     enable_audio_bell = false;
  #     update_check_interval = 0;
  #   };
  # };

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
  # system.stateVersion = "24.05"; # Did you read the comment?
  system.stateVersion = "24.11"; # Did you read the comment?
}
