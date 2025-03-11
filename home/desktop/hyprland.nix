{config, pkgs, ...}: let
  hyprland_configPath = "${config.home.homeDirectory}/spk/my-nixos/home/desktop/dotfile/hypr";
  waybar_configPath = "${config.home.homeDirectory}/spk/my-nixos/home/desktop/dotfile/waybar";
  mako_configPath = "${config.home.homeDirectory}/spk/my-nixos/home/desktop/dotfile/mako";
  tofi_configPath = "${config.home.homeDirectory}/spk/my-nixos/home/desktop/dotfile/tofi";
in {
  xdg.configFile."hypr".source = config.lib.file.mkOutOfStoreSymlink hyprland_configPath;
  xdg.configFile."waybar".source = config.lib.file.mkOutOfStoreSymlink waybar_configPath;
  xdg.configFile."mako".source = config.lib.file.mkOutOfStoreSymlink mako_configPath;
  xdg.configFile."tofi".source = config.lib.file.mkOutOfStoreSymlink tofi_configPath;
  
  home.packages = with pkgs;[
    # 身份验证守护程序
    hyprpolkitagent
    # 窗口管理器，暂时未使用
    # hyprsome
    waybar
    swaybg
    # hyprpaper
    # 视频壁纸，但是资源貌似占用较高，这里暂时不用
    mpvpaper
    ffmpeg
    
    hyprlock
    hypridle
    mako
    # notify-send 使用
    libnotify
    tofi

    qt6.qtwayland

    wev
    # screen shot
    flameshot
    # flameshot = callPackage inputs.nixpkgs.pkgs.flameshot { enableWlrSupport = true; };
    # (pkgs.callPackage "${pkgs.flameshot}/package.nix" { enableWlrSupport = true; })

    hyprshot
    jq
    grim
    slurp
    # 剪切板
    wl-clipboard

    # PDF reader
    zathura
    # music
    # playerctl
  ];
}
