{
  lib,
  config,
  ...
}: {
  options = {
    nixos = {
      displayServer.xserver.enable = lib.mkEnableOption "X11 display server";

      windowManager.i3 = {
        enable = lib.mkEnableOption "i3 window manager";

        usei3Status = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Enable i3status integration for i3.";
        };
      };

      displayManager.ly.enable = lib.mkEnableOption "Ly display manager";
    };
  };

  config = lib.mkMerge [
    {
      assertions = [
        {
          assertion = !config.nixos.windowManager.i3.enable || config.nixos.displayServer.xserver.enable;
          message = "nixos.windowManager.i3.enable requires nixos.displayServer.xserver.enable";
        }
      ];
    }

    (lib.mkIf config.nixos.displayServer.xserver.enable {
      services.xserver = {
        enable = true;
        autoRepeatDelay = 200;
        autoRepeatInterval = 35;
        xkb.options = "caps:escape";
      };
    })

    (lib.mkIf config.nixos.windowManager.i3.enable {
      services.xserver.windowManager.i3.enable = true;
    })

    (lib.mkIf config.nixos.displayManager.ly.enable {
      services.displayManager.ly = {
        enable = true;
        settings = {
          animation = "none";
          hide_borders = false;
          clock = "%Y-%m-%d %H:%M";
        };
      };
    })
  ];
}
