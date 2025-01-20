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
    mpvpaper
    hyprlock
    hypridle
    mako
    libnotify
    tofi

    # screen shot
    hyprshot
    jq
    grim
    slurp
    wl-clipboard
    libnotify

    # PDF reader
    zathura
	];
}
