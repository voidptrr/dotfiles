{
  inputs,
  hostname,
  username,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-p14s-amd-gen6
    ./hardware-configuration.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = hostname;
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/London";

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

  programs.zsh.enable = true;
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    shell = pkgs.zsh;
  };

  hardware.alsa.enablePersistence = true;
  security.rtkit.enable = true;

  environment.systemPackages = with pkgs; [
    brightnessctl
    pulseaudio
    alsa-utils
    (polybar.override {
      i3Support = true;
      pulseSupport = true;
    })
  ];

  fonts.packages = with pkgs; [source-code-pro];
  system.stateVersion = "25.11";
}
