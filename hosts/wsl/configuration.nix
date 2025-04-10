
{ config, lib, pkgs, ... }:

{
  wsl.enable = true;
  wsl.defaultUser = "nixos";

  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;

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
        export PATH="$PATH:/home/nixos/spk-docs/my_scripts"
    '';
  in {
    completion.enable = true;
    loginShellInit = envExtra;
  };
 
  # 启用 Flakes 特性以及配套的 nix 命令行工具
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    # home包
    neofetch
   
    # docker support
    docker-compose

    # svn支持
    subversion
    # terminal
    tmux
  ];

  fonts.packages = with pkgs; [
    wqy_zenhei
  ];

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
