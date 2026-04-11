{
  hostname,
  username,
  pkgs,
  ...
}: {
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = hostname;
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/London";
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
