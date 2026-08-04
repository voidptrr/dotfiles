{
  config,
  lib,
  ...
}: {
  options.my.nixos.desktop.xserver.enable = lib.mkEnableOption "X11 display server";

  config = lib.mkIf config.my.nixos.desktop.xserver.enable {
    services.xserver = {
      enable = true;
      autoRepeatDelay = 200;
      autoRepeatInterval = 35;
      xkb.options = "caps:escape";
    };
  };
}
