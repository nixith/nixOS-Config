{ ... }: {
  services.mako = {
    enable = true;
    backgroundColor = "#1E1E2E";
    textColor = "#cdd6f4";
    borderColor = "#89b4fa";
    progressColor = "over #313244";
    extraConfig = ''
      [urgency=high]
      border-color=#fab387
    '';
  };
}
