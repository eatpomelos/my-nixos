{ pkgs, inputs, ... }:

{
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

  system.activationScripts.installCaddyWallpapers = ''
    ${pkgs.rsync}/bin/rsync -avz --chmod=D2777,F777 ${inputs.rime-ice}/ /home/spikely/.local/share/fcitx5/rime
  '';
}
