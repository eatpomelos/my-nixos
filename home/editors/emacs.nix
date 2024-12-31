{ pkgs, ... }:
{
  # 安装emacs相关得到包
 	home.packages = with pkgs;[
		# utils	
		ripgrep
		fd
		emacs
	  emacsPackages.lsp-bridge
	];
}
