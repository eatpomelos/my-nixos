{ config, pkgs, ... }:

{
	home.username = "spikely";
	home.homeDirectory = "/home/spikely";

	xresources.properties = {
		"Xcursor.size" = 16;
		"Xft.dpi" = 172;
	};	

	home.packages = with pkgs;[
		neofetch
		
		# utils	
		ripgrep
		jq
		fd
		fzf

		# editor
		emacs

		# browser
		arandr
	
	];

	programs.git = {
		enable = true;
		userName = "spikely";
		userEmail = "spikeluoyu@outlook.com";
	};
	
	programs.bash = {
		enable = true;
		enableCompletion = true;
	};

	home.stateVersion = "24.11";

	programs.home-manager.enable = true;
}
