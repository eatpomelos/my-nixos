{ pkgs, ... }:
{
  # 设置光标大小
  xresources.properties = {
		"Xcursor.size" = 16;
		"Xft.dpi" = 172;
	};	

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

    
  # 安装一些基础的包
 	home.packages = with pkgs;[
		neofetch
    
		# utils	
		jq
		fzf

		# browser
    # google-chrome
    vivaldi
	];
}
