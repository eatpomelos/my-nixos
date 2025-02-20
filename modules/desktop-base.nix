{ pkgs, inputs, userName, ... }:

{
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

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  # 开启xwayland用于运行x11应用
  programs.xwayland.enable = true;
  
  # greetd守护进程，这里默认直接启动hyprland
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.hyprland}/bin/Hyprland";
        user = "${userName}";
      };
      default_session = initial_session;
    };
  };

  programs.clash-verge = {
	  enable = true;
	  package = pkgs.clash-verge-rev;
	  #package = pkgs.mihomo-party;
	  tunMode = true;
  };
  
  #inputmethod
  i18n.inputMethod = {
	  type = "fcitx5";
	  enable = true;
	  fcitx5 = {
      addons = with pkgs; [
        librime
        # for rime-ice
        librime-lua
        rime-zhwiki
		    rime-data
		    fcitx5-gtk
        fcitx5-chinese-addons
		    fcitx5-rime
	    ];
      # 使用wayland前端，避免GTK_IM_MODULE 告警
      # 禁用wayland前端，目前发现在edge浏览器中使用会导致漏字
      # waylandFrontend = true;
    };
  };

  system.activationScripts.installRime-ice = ''
    ${pkgs.rsync}/bin/rsync -avz --chmod=D2777,F777 ${inputs.rime-ice}/ /home/${userName}/.local/share/fcitx5/rime
  '';
  
 # 文件资源管理器
 programs.thunar.enable = true;

 # locate 提供文件快速检索能力
  services.locate = {
    enable = true;
    package = pkgs.mlocate;
    interval = "hourly";
    localuser = null;
  };

  # Enable Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

}
