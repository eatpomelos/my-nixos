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
	
	];

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
