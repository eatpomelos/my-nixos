
{ config, lib, pkgs, inputs, ... }:
{
  # sunshine 作为串流服务端
  security.wrappers.sunshine = {
    owner = "root";
    group = "root";
    capabilities = "cap_sys_admin+p";
    source = "${pkgs.sunshine}/bin/sunshine";
  };

  # Requires to simulate input
  boot.kernelModules = ["uinput"];
  services.udev.extraRules = ''
    KERNEL=="uinput", SUBSYSTEM=="misc", OPTIONS+="static_node=uinput", TAG+="uaccess"
  '';

  networking.firewall = {
    allowedTCPPortRanges = [
      {
        from = 47984;
        to = 48010;
      }
    ];
    allowedUDPPortRanges = [
      {
        from = 47998;
        to = 48010;
      }
    ];
  };


  environment.systemPackages = with pkgs; [
     # 用于串流到其他PC
     moonlight-qt
  ];
}
