{ pkgs, config, ... }:

{
  
  # for g mode
  boot.kernelModules = [ "acpi_call" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];

  programs.steam.enable = true;
  environment.systemPackages =  with pkgs; [
    fanctl
    steam
    mission-center
    dell-command-configure
  ];
}
