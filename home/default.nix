{ pkgs, userName, ...}: {
  imports = [
    ./base.nix
    ./shell.nix
    ./desktop
  ];

  home = {
    username = "${userName}";
    homeDirectory = "/home/${userName}";
    stateVersion = "24.11";
  };
  
  programs.home-manager.enable = true;
}
