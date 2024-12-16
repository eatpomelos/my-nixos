{config, pkgs, ...}: let
  configPath = "${config.home.homeDirectory}/spk/my-nixos/home/desktop/hypr";
in {
  xdg.configFile."hypr".source = config.lib.file.mkOutOfStoreSymlink configPath;
  
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
