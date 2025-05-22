{ pkgs, ... }:

{
  # 系统环境基础包
  environment.systemPackages = with pkgs; [
  # Flakes 通过 git 命令拉取其依赖项，所以必须先安装好 git
  git
  vim
  wget

  # man手册
  man
  man-pages
  man-pages-posix
  
  # 
  gnumake
  cmake
  libtool
  gcc
  gccMultiStdenv
  # 32位gcc
  pkgsi686Linux.gcc
  gdb
  cppcheck
  glibc
  binutils
  ctags
  
  # 提供内核模块管理工具
  kmod
  
  # utils	
  jq

  libclang
  clang

  # utils
  curl
  killall
  
  # unrar
  unrar
  
  # unzip
  unzip
  pkg-config

  # for mount
  # cifs-utils
  sambaFull
  ];
  environment.extraInit="
    export PKG_CONFIG_PATH=/run/current-system/sw/lib/pkgconfig:$PKG_CONFIG_PATH
  ";
  
}
