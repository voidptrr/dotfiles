{pkgs, ...}: {
  hardware.alsa.enablePersistence = true;
  security.rtkit.enable = true;

  fonts.packages = with pkgs; [source-code-pro jetbrains-mono];
  environment.systemPackages = with pkgs; [
    brightnessctl
    pulseaudio
    alsa-utils
    xclip
    wl-clipboard
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
