{
  inputs,
  hostname,
  username,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-p14s-amd-gen6
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.extraModprobeConfig = ''
    options snd-intel-dspcfg dsp_driver=1
  '';

  networking.hostName = hostname;
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/London";

  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    xkb.options = "caps:escape";
    windowManager.i3.enable = true;
  };

  services.displayManager.ly.enable = true;

  programs.zsh.enable = true;
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    shell = pkgs.zsh;
    packages = with pkgs; [opencode];
  };

  hardware.alsa.enablePersistence = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    jack.enable = true;
    wireplumber.enable = true;
  };

  environment.systemPackages = with pkgs; [
    vim
    git
    brightnessctl
    pulseaudio
    alsa-utils
  ];

  fonts.packages = with pkgs; [source-code-pro];
  system.stateVersion = "25.11";
}
