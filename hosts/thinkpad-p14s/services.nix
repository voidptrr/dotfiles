{...}: {
  services = {
    xserver = {
      enable = true;
      autoRepeatDelay = 200;
      autoRepeatInterval = 35;
      xkb.options = "caps:escape";
      windowManager.i3.enable = true;
    };

    libinput = {
      enable = true;
      touchpad.naturalScrolling = true;
    };

    displayManager.ly.enable = true;

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
