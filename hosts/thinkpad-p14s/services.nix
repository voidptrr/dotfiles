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
      touchpad = {
        naturalScrolling = true;
        tapping = false;
      };
    };

    displayManager.ly = {
      enable = true;
      settings = {
        animation = "none";
        hide_borders = false;
        clock = "%Y-%m-%d %H:%M";
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
