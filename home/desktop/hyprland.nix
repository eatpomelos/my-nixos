{config, pkgs, ...}: let
  hyprland_configPath = "${config.home.homeDirectory}/spk/my-nixos/home/desktop/hypr";
  waybar_configPath = "${config.home.homeDirectory}/spk/my-nixos/home/desktop/waybar";
  mako_configPath = "${config.home.homeDirectory}/spk/my-nixos/home/desktop/mako";
in {
  xdg.configFile."hypr".source = config.lib.file.mkOutOfStoreSymlink hyprland_configPath;
  xdg.configFile."waybar".source = config.lib.file.mkOutOfStoreSymlink waybar_configPath;
  xdg.configFile."mako".source = config.lib.file.mkOutOfStoreSymlink mako_configPath;
  
  home.packages = with pkgs;[
    waybar
    swaybg
    # hyprpaper
    mpvpaper
    hyprlock
    mako
    tofi
	];
}
