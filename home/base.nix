{ pkgs, inputs, userName, ... }:
{
  # 设置光标大小
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  programs.git = {
    enable = true;
    userName = "${userName}";
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
    
    # vlc目前在播放某些视频时有些问题，先使用mpv
    vlc
    mpv

    # browser
    microsoft-edge
    # google-chrome
   
    # 屏幕背光
    brightnessctl
    # picom

    # chat
    wechat-uos
    qq
    
    qemu
    # 图片浏览器
    gthumb
    
    # nas 客户端
    synology-drive-client
  ];

   
#  # 启动synology-drive from: https://discourse.nixos.org/t/automatic-program-start-up-on-login-with-xorg/34261/2
 
#   systemd.user.services.synology-drive = {
#         description = "Synology Cloud Sync";
#         enable = true;
#         serviceConfig.PassEnvironment = "DISPLAY";
# #       wantedBy = ["multi-user.target"];       #afer login
#         wantedBy = ["graphical-session.target"];
#         partOf   = ["graphical-session.target"];
#         path     = [ pkgs.synology-drive-client ];

#         script = ''
#                 #!/run/current-system/sw/bin/bash

#                 sleep 30
#                 cd ${pkgs.synology-drive-client}/bin && synology-drive 
#         '';
        
#         serviceConfig = {
#                 RemainAfterExit = true;
#         };
#   };
  # mpv配置,启用硬件加速
  xdg.configFile."mpv/mpv.conf".text = ''
      hwdec=auto
  '';
}
