{ pkgs, ... }:
{
  services.emacs = {
    enable = true;
    package = pkgs.emacs-gtk;
  };

  environment.systemPackages = with pkgs; [
    git nodejs wmctrl xdotool
    # eaf-browser
    aria 
    # utils
    ripgrep
    fd
    libtool
    pandoc
    # emacsPackages.lsp-bridge
    # python配置
    pyright
    (python313.withPackages (
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

        # eaf dependenciesge
        tld
        lxml
        qrcode
        pysocks
        pymupdf
        pypinyin
        psutils
        retry
        markdown
        pillow

        # eaf-music dependenciesge
        pytaglib
        pillow
        mutagen
        certifi
        pycryptodome
        rsa
        flask
      ]
    ))
    # python313Packages.pymupdf
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
    
    # mupdf
    
    # perl相关包
    perl540
    perl540Packages.PLS
    perlnavigator
    
    # eaf dependenciesge
    pkg-config
    libinput
    libinput-gestures
    libevdev
    libudev-zero
    
    sdcv
  ];
}

