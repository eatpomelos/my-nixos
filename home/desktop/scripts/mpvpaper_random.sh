#!/usr/bin/env bash

# 设置默认视频壁纸路径
mpvpaper_dir=~/spk-shareFile/mpvpapers

if [ -d "$mpvpaper_dir" ]; then
  mpvpaper_file=$(find "$mpvpaper_dir" -type f | shuf -n 1)
else
  echo "目录不存在: $mpvpaper_dir"
fi

# 启动壁纸，如果存在视频壁纸则使用mpvpaper，否则设置静态壁纸
if [ -e $mpvpaper_file ]; then
    curr_mpvpaper_pid=$(pgrep -f 'mpvpaper' | grep -v $$ | grep -v $(basename $0))
    if [ -n "$curr_mpvpaper_pid" ]; then
        kill -9 $curr_mpvpaper_pid
        sleep 1
    fi
    nice -n 19 mpvpaper -o "--no-audio --loop-playlist --panscan=1 --hwdec=auto --framedrop=vo --profile=low-latency " '*' $mpvpaper_file
else
    curr_swaybg_pid=$(pgrep -f 'swaybg' | grep -v $$ | grep -v $(basename $0))
    if [ -z "$curr_swaybg_pid" ]; then
        # 如果不存在视频壁纸，则配置静态壁纸，静态壁纸一定存在
        swaybg --output '*' --mode fill --image /etc/nixos/home/desktop/wallpaper.png
    fi
fi

