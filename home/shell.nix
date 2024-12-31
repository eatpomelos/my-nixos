{ pkgs, ... }:
{
	programs.bash = {
		enable = true;
		enableCompletion = true;
	};

  # 用kitty作为终端
  programs.kitty = {
    enable = true;
    # font.name = "Dejavu Sans";
    # font.size = 10;
    keybindings = {
      "ctrl+c" = "copy_or_interrupt";
    };
    settings = {
      scrollback_lines = 100000;
      enable_audio_bell = false;
      update_check_interval = 0;
    };
  };

  
  # 启用 starship，这是一个漂亮的 shell 提示符
  programs.starship = {
    enable = true;
    # 自定义配置
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  # 配置fzf
  programs.fzf = {
    enable = true;
    package = pkgs.fzf;
    enableBashIntegration = true;
    changeDirWidgetCommand = "fd --type d";
    changeDirWidgetOptions = [
      "--preview 'tree -C {} | head -200'"
    ];
    defaultCommand = "fd --type f";
    defaultOptions = [
      "--height 40%"
      "--border"
    ];
    fileWidgetCommand = "fd --type f";
    fileWidgetOptions = [ "--preview 'head {}'" ];
    historyWidgetOptions = [
      "--sort"
      "--exact"
    ];
  };
}
