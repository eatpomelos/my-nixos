#!/usr/bin/env bash

# 设置默认视频壁纸路径
mpvpaper_file=/home/spikely/default-mpvpaper.mp4

# 先启动hyprlock代替greeter程序
hyprlock

# 启动壁纸，如果存在视频壁纸则使用mpvpaper，否则设置静态壁纸
if [ -e $mpvpaper_file ]; then
    nice -n 19 mpvpaper -o "--no-audio --loop-playlist --panscan=1 --hwdec=auto --framedrop=vo --profile=low-latency " '*' $mpvpaper_file
else
    # 如果不存在视频壁纸，则配置静态壁纸，静态壁纸一定存在
    swaybg --output '*' --mode fill --image /etc/nixos/home/desktop/wallpaper1.jpg
fi
