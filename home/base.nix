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
    # 文泉驿字体，后面的终端以及emacs都会用到
    wqy_zenhei
    
		# utils	
		jq

    # vlc目前在播放某些视频时有些问题，先使用mpv
    # vlc
    mpv
    smplayer

		# browser
    microsoft-edge
    # google-chrome
    # vivaldi

    # 编程相关
    libclang
    clang
    # jdk11
    
    # 屏幕背光
    brightnessctl
    # picom

    wechat-uos
    qq
    
    qemu
    # 图片浏览器
    gthumb
	];
}
