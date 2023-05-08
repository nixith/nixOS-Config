{pkgs, ...}: {
  home.packages = with pkgs; [spotify-tui];

  services.spotifyd = {
    enable = true;
    settings = {
      global = {
        audio_format = "S16";
        autoplay = true;
        backend = "pulseaudio";
        bitrate = 320;
        cache_path = "cache_directory";
        dbus_type = "session";
        device = "default";
        device_name = "nixos";
        device_type = "computer";
        initial_volume = "90";
        max_cache_size = 1000000000;
        mixer = "PCM";
        no_audio_cache = true;
        normalisation_pregain = -10;
        on_song_change_hook = "command_to_run_on_playback_events";
        # proxy = "http://proxy.example.org:8080";
        use_keyring = true;
        use_mpris = true;
        volume_controller = "alsa";
        volume_normalisation = true;
        # zeroconf_port = 1234;
      };
    };
  };
}
