{pkgs, userName, ...}: {
  # Enable sound with pipewire.
  hardware.pulseaudio = {
    enable = false;
    extraConfig = "load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1";
  };
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    #systemWide = true;
    # If you want to use JACK applications, uncomment this
    # jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    # media-session.enable = true;
  };
  
  # 配置mpd，用于播放音乐
  services.mpd = {
    enable = true;
    user = "${userName}";
    musicDirectory = "/home/spikely/Music";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "My PipeWire Output"
      }
      '';
    network = {
      listenAddress = "any";
    };
  };
  
  environment.systemPackages = with pkgs; [
    pamixer
    pavucontrol
    ncmpcpp
  ];
}
