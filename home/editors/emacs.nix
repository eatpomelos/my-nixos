{ pkgs, ... }:
{
  # 安装emacs相关得到包
  home.packages = with pkgs;[
    # utils
    ripgrep
    fd
    emacs
    libtool
    pandoc
    # emacsPackages.lsp-bridge
    # python配置
    pyright
    (python311.withPackages (
      ps:
      with ps; [
        ruff
        black # python formatter
        # debugpy
        pyqt6
        pyqt6-sip
        pyqt6-webengine
        cookies

        # my commonly used python packages
        jupyter
        ipython
        pandas
        requests
        pyquery
        pyyaml
        boto3

        ## emacs's lsp-bridge dependenciesge
        epc
        orjson
        sexpdata
        six
        setuptools
        paramiko
        rapidfuzz
        watchdog
        packaging
        python-lsp-server
      ]
    ))
    # popweb 英语读音
    mpg123
    # lsp-language-server
    nixd
    basedpyright
    texlab
    lua-language-server
    rust-analyzer
    typescript-language-server
    cmake-language-server
    bash-language-server
    clojure-lsp
    hyprls
    
    # perl相关包
    perl540
    perl540Packages.PLS
    perlnavigator
    
    # eaf dependenciesge
    # pkg-config
    # libinput
    # libevdev
    # libudev-zero

    sdcv
  ];
}
