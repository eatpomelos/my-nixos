{pkgs, ...}: {
  
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
