{pkgs, ...}: {
  hardware.alsa.enablePersistence = true;
  security.rtkit.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.mononoki
    source-code-pro
  ];
  environment.systemPackages = with pkgs; [
    brightnessctl
    pulseaudio
    alsa-utils
    xclip
    wl-clipboard
    man-pages
    scc
  ];

  services = {
    libinput = {
      enable = true;
      touchpad = {
        naturalScrolling = true;
        tapping = false;
      };
    };

    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack.enable = true;
      wireplumber.enable = true;
    };
  };
}
