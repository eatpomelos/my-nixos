# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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
  
  # Enable the KDE Plasma Desktop Environment.
  # services.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "cn";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # USB Automounting
  services.gvfs.enable = true;
  # services.udisks2.enable = true;
  # services.devmon.enable = true;

  # Enable USB Guard
  # services.usbguard = {
  #   enable = true;
  #   dbus.enable = true;
  #   implicitPolicyTarget = "block";
  #   # FIXME: set yours pref USB devices (change {id} to your trusted USB device), use `lsusb` command (from usbutils package) to get list of all connected USB devices including integrated devices like camera, bluetooth, wifi, etc. with their IDs or just disable `usbguard`
  #   rules = ''
  #     allow id {id} # device 1
  #     allow id {id} # device 2
  #   '';
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

  # Enable touchpad support (enabled default in most desktopManager).
    services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.spikely = {
    isNormalUser = true;
    description = "spikely";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  kate
    #  thunderbird
    ];
  };

  # Install firefox.
  # programs.firefox.enable = true;
  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  programs.xwayland.enable = true;
  
  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     default_session = let
  #       greetd_config = pkgs.writeText "greetd_config" ''
  #       exec = sh -c "${config.programs.regreet.package}/bin/regreet; ${pkgs.hyprland}/bin/hyprctl dispatch exit"
  #       misc {
  #           disable_hyprland_logo = true
  #           disable_splash_rendering = true
  #           disable_hyprland_qtutils_check = true
  #       }
  #       '';
  #     in {
  #       command = "${pkgs.hyprland}/bin/Hyprland --config ${greetd_config}";
  #       user = "greeter";
  #     };
  #   };
  # };

  programs.regreet = {
    enable = true;
    package = pkgs.greetd.regreet;
    # theme.package = pkgs.gnome-themes-extra;
    # theme.name = "Adwaita";
    settings = {
      backgroud = lib.mkForce {
        path = "/home/spikely/spk/my-nixos/home/desktop/lock.png";
        fit = "Fill";
      };
      GTK = lib.mkForce {
        cursor_theme_name = "Adwaita";
        font_name = "Cantarell 16";
        icon_theme_name = "Adwaita";
        theme_name = "Adwaita";
      };
      appearance = lib.mkForce {
        greeting_msg = "Welcome back spikely!";
      };
    };
  };

  programs.clash-verge = {
	enable = true;
	package = pkgs.clash-verge-rev;
	#package = pkgs.mihomo-party;
	tunMode = true;
  };
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

   # Enable Bluetooth
 hardware.bluetooth.enable = true;
 hardware.bluetooth.powerOnBoot = false;
 services.blueman.enable = true;
 
 # locate
 services.locate = {
   enable = true;
   package = pkgs.mlocate;
   interval = "hourly";
   localuser = null;
 };



  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     # git
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     # inputs.wezterm.packages.${pkgs.system}.default
     gnumake
     gcc
     
     overskride
    # icon fonts
    material-design-icons
    font-awesome

     # 音频编辑器
     # audacity
     
     # usb
     usbutils

     xdg-user-dirs-gtk
  ];
 
  environment.variables.EDITOR = "vim";

  # environment.sessionVariables.NIXOS_OZONE_WL = "1";  # enable apps use xwayland, fix for fcitx
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

  #inputmethod
 i18n.inputMethod = {
	type = "fcitx5";
	enable = true;
	fcitx5 = {
    addons = with pkgs; [
      librime
      rime-zhwiki
		  rime-data
		  fcitx5-gtk
      fcitx5-chinese-addons
		  fcitx5-rime
	  ];
    # 使用wayland前端，避免GTK_IM_MODULE 告警
    waylandFrontend = true;
  };
 };

 programs.thunar.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  networking.extraHosts = 
	''
		185.199.108.133 raw.githubusercontent.com
    31.209.137.10 bifrost.vivaldi.com
	'';

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  #system.stateVersion = "24.05"; # Did you read the comment?
   system.stateVersion = "24.11"; # Did you read the comment?

}
