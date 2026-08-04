{
  config,
  lib,
  ...
}: {
  options.my.nixos.services.ly.enable = lib.mkEnableOption "Ly display manager";

  config = lib.mkIf config.my.nixos.services.ly.enable {
    services.displayManager.ly = {
      enable = true;
      settings = {
        animation = "none";
        hide_borders = false;
        clock = "%Y-%m-%d %H:%M";
      };
    };
  };
}
