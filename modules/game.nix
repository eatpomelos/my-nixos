{ pkgs, ... }:

{
  programs.steam.enable = true;
  environment.systemPackages =  with pkgs; [
    fanctl
    steam
    mission-center
    dell-command-configure
  ];
}
