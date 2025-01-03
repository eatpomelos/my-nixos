# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

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

  # 开启英伟达显卡驱动
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    open = false;
    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/os-specific/linux/nvidia-x11/default.nix
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    # required by most wayland compositors!
    modesetting.enable = true;
    powerManagement.enable = true;
  };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
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

  programs.regreet = {
    enable = true;
    package = pkgs.greetd.regreet;
    settings = {
      backgroud = {
        path = "/home/spikely/spk/my-nixos/home/desktop/lock.png";
        fit = "Fill";
      };
      GTK = {
        cursor_theme_name = "Adwaita";
        font_name = "Cantarell 16";
        icon_theme_name = "Adwaita";
        theme_name = "Adwaita";
      };
      appearance = {
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
     
     overskride
         
    # icon fonts
    material-design-icons
    font-awesome
  ];
 
  environment.variables.EDITOR = "vim";

  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  #environment.sessionVariables.NIXOS_OZONE_WL = "1";  # enable apps use xwayland, fix for fcitx
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

  #inputmethod
 i18n.inputMethod = {
	type = "fcitx5";
	enable = true;
	fcitx5.addons = with pkgs; [
		rime-data
		fcitx5-gtk
		fcitx5-rime
	];
 };

 programs.thunar = {
   enable = true;
 };

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
