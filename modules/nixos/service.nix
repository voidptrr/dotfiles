{
  lib,
  pkgs,
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
        displayManager.sessionCommands = ''
          if ${pkgs.xorg.xrandr}/bin/xrandr | grep -q '^eDP-1 connected'; then
            ${pkgs.xorg.xrandr}/bin/xrandr --output eDP-1 --mode 1920x1200 --scale 1.04x1.00
          fi
        '';
      };
    })

    (lib.mkIf config.nixos.windowManager.i3.enable {
      services.xserver.windowManager.i3 = {
        enable = true;
        extraPackages = lib.optionals config.nixos.windowManager.i3.usei3Status [pkgs.i3status];
      };
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
