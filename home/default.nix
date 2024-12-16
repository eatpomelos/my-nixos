{userName, ...}: {
  imports = [
    ./base.nix
    ./shell.nix
    ./editors
    ./desktop
  ];

  home = {
    username = "${userName}";
    homeDirectory = "/home/${userName}";
    stateVersion = "24.11";
  };
  
  programs.home-manager.enable = true;
}
