{ config, pkgs, ... }:

{

  # Gitea
  virtualisation.oci-containers.containers."gitea" = {
    autoStart = true;
    image = "docker.gitea.com/gitea:latest";
    environment = {
      USER_UID = "1000";
      USER_GID = "1000";
    };
    volumes = [
      "/home/nixos/spk/Gitea:/data"
      "/etc/localtime:/etc/localtime:ro"
    ];
    ports = [
      "3000:3000"
      "222:22"
    ];
  };

}
