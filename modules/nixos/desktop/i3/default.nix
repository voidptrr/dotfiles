{
  config,
  lib,
  ...
}: {
  options.my.nixos.desktop.i3 = {
    enable = lib.mkEnableOption "i3 window manager";

    usei3Status = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable i3status integration for i3.";
    };
  };

  config = lib.mkMerge [
    {
      assertions = [
        {
          assertion = !config.my.nixos.desktop.i3.enable || config.my.nixos.desktop.xserver.enable;
          message = "my.nixos.desktop.i3.enable requires my.nixos.desktop.xserver.enable";
        }
      ];
    }

    (lib.mkIf config.my.nixos.desktop.i3.enable {
      services.xserver.windowManager.i3.enable = true;
    })
  ];
}
