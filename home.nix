{ config, pkgs, ... }:

{
	home.username = "spikely";
	home.homeDirectory = "/home/spikely";

	xresources.properties = {
		"Xcursor.size" = 16;
		"Xft.dpi" = 172;
	};	

	home.packages = with pkgs;[
		neofetch
		
    mlocate
		# utils	
		ripgrep
		jq
		fd
		fzf

		# editor
		emacs
    wqy_zenhei

		# browser
    # google-chrome
    vivaldi

    # display
		# arandr
	  emacsPackages.lsp-bridge

    # desktop
    waybar
    swaybg
    # hyprpaper
    mpvpaper
    hyprlock
    mako
    tofi

	];

  # 壁纸配置
  # services.hyprpaper = {
  #   enable = true;
  #   package = pkgs.hyprpaper;
  #   settings = {
  #     ipc = "on";
  #     splash = false;
  #     splash_offset = 2.0;
  #     preload = "/home/spikely/spk/my-nixos/wallpaper0.jpg";
  #     wallpaper = ",/home/spikely/spk/my-nixos/wallpaper1.jpg";
  #   };
  # };

	programs.git = {
		enable = true;
		userName = "spikely";
		userEmail = "spikeluoyu@outlook.com";
	};
	
	programs.bash = {
		enable = true;
		enableCompletion = true;
	};

    # 启用 starship，这是一个漂亮的 shell 提示符
  programs.starship = {
    enable = true;
    # 自定义配置
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

	home.stateVersion = "24.11";

	programs.home-manager.enable = true;
}
