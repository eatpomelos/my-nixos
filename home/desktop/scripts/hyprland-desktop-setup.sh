#!/usr/bin/env bash

# 先启动hyprlock代替greeter程序
hyprlock

# 随机播放一个视频壁纸
mpvpaper_dir=~/spk-shareFile/mpvpapers

if [ -d "$mpvpaper_dir" ]; then
  mpvpaper_file=$(find "$mpvpaper_dir" -type f | shuf -n 1)
fi

# 启动壁纸，如果存在视频壁纸则使用mpvpaper，否则设置静态壁纸
if [ -e $mpvpaper_file ]; then
     nice -n 19 mpvpaper -o "--no-audio --loop-playlist --panscan=1 --hwdec=auto --framedrop=vo --profile=low-latency " '*' $mpvpaper_file
else
     swaybg --output '*' --mode fill --image /etc/nixos/home/desktop/wallpaper.png
fi


