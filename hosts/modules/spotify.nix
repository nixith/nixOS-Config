{config, ...}: let
  usernamePath = "/var/lib/spotifyd/username";
  passwordPath = "/var/lib/spotifyd/password";
in {
  sops.secrets."spotifyd/password" = {
    path = passwordPath;
    #  group = "spotifyd";
    #  mode = "0440";
  };
  sops.secrets."spotifyd/username" = {
    path = usernamePath;
    #  group = "spotifyd";
    #  mode = "0440";
  };
  systemd.services.spotifyd.serviceConfig.LoadCredential = [
    "username:${usernamePath}"
    "password:${passwordPath}"
  ];

  services.spotifyd = {
    enable = true;
    settings = {
      global = {
        audio_format = "S16";
        autoplay = true;
        username_cmd = "cat $CREDENTIALS_DIRECTORY/username";
        password_cmd = "cat $CREDENTIALS_DIRECTORY/password";
        backend = "pulseaudio";
        bitrate = 320;
        cache_path = "cache_directory";
        #dbus_type = "system";
        device = "default";
        device_name = "patchouli";
        device_type = "computer";
        initial_volume = "90";
        max_cache_size = 1000000000;
        mixer = "PCM";
        no_audio_cache = true;
        normalisation_pregain = -10;
        #on_song_change_hook = "command_to_run_on_playback_events";
        # proxy = "http://proxy.example.org:8080";
        #use_keyring = true;
        use_mpris = false;
        volume_controller = "alsa";
        volume_normalisation = true;
        # zeroconf_port = 1234;
      };
    };
  };
}

