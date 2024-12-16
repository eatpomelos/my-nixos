{ pkgs, ... }:
{
  # 安装emacs相关得到包
 	home.packages = with pkgs;[
		# utils	
    wqy_zenhei
		ripgrep
		fd
		emacs
	  emacsPackages.lsp-bridge
	];
}
