{
  lib,
  osConfig,
  ...
}: let
  i3 = osConfig.nixos.windowManager.i3;
in {
  imports = [
    ./i3status.nix
  ];

  config = lib.mkMerge [
    {
      assertions = [
        {
          assertion = !i3.usei3Status || i3.enable;
          message = "nixos.windowManager.i3.usei3Status requires nixos.windowManager.i3.enable";
        }
      ];
    }

    (lib.mkIf i3.enable {
      xsession.windowManager.i3 = {
        enable = true;
        config = {
          modifier = "Mod4";
          terminal = "ghostty";

          floating = {
            modifier = "Mod4";
            border = 2;
            titlebar = false;
          };

          focus.followMouse = true;

          window = {
            hideEdgeBorders = "none";
            border = 2;
            titlebar = false;
            commands = [
              {
                criteria.title = "coding";
                command = "floating enable, resize set 1400 900, move position center";
              }
            ];
          };

          colors = {
            focused = {
              border = "#e6c384";
              background = "#1f1f28";
              text = "#e6c384";
              indicator = "#e6c384";
              childBorder = "#e6c384";
            };
            unfocused = {
              border = "#444b6a";
              background = "#1f1f28";
              text = "#7f8490";
              indicator = "#444b6a";
              childBorder = "#444b6a";
            };
            focusedInactive = {
              border = "#444b6a";
              background = "#1f1f28";
              text = "#7f8490";
              indicator = "#444b6a";
              childBorder = "#444b6a";
            };
            urgent = {
              border = "#c34043";
              background = "#1f1f28";
              text = "#c34043";
              indicator = "#c34043";
              childBorder = "#c34043";
            };
          };
          bars = [
            {
              position = "top";
              statusCommand = "i3status";
              trayOutput = "primary";
              fonts = {
                names = ["Source Code Pro"];
                size = 13.0;
              };
              colors = {
                background = "#1f1f28";
                statusline = "#dcd7ba";
                separator = "#7f8490";
                focusedWorkspace = {
                  border = "#1f1f28";
                  background = "#1f1f28";
                  text = "#dcd7ba";
                };
                activeWorkspace = {
                  border = "#2a2a37";
                  background = "#2a2a37";
                  text = "#dcd7ba";
                };
                inactiveWorkspace = {
                  border = "#1f1f28";
                  background = "#1f1f28";
                  text = "#7f8490";
                };
                urgentWorkspace = {
                  border = "#c34043";
                  background = "#c34043";
                  text = "#ffffff";
                };
                bindingMode = {
                  border = "#c34043";
                  background = "#c34043";
                  text = "#ffffff";
                };
              };
              extraConfig = ''
                separator_symbol "|"
              '';
            }
          ];
          keybindings = {
            "XF86MonBrightnessUp" = "exec --no-startup-id brightnessctl set +5%";
            "XF86MonBrightnessDown" = "exec --no-startup-id brightnessctl set 5%-";
            "XF86AudioMute" = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle";
            "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5%";
            "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5%";
            "XF86AudioMicMute" = "exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle";

            "Mod4+Return" = "exec --no-startup-id ghostty";
            "Mod4+m" = "exec --no-startup-id rofi -show drun -normal-window";
            "Mod4+f" = "exec --no-startup-id firefox";
            "Mod4+c" = "exec --no-startup-id ghostty --title=coding";
            "Mod4+Shift+q" = "kill";

            "Mod4+h" = "focus left";
            "Mod4+j" = "focus down";
            "Mod4+k" = "focus up";
            "Mod4+l" = "focus right";

            "Mod4+space" = "layout toggle split";
            "Mod4+Control+r" = "reload";

            "Mod4+1" = "workspace number 1";
            "Mod4+2" = "workspace number 2";
            "Mod4+3" = "workspace number 3";
            "Mod4+4" = "workspace number 4";
            "Mod4+5" = "workspace number 5";
            "Mod4+6" = "workspace number 6";
            "Mod4+7" = "workspace number 7";
            "Mod4+8" = "workspace number 8";
            "Mod4+9" = "workspace number 9";

            "Mod4+Shift+1" = "move container to workspace number 1";
            "Mod4+Shift+2" = "move container to workspace number 2";
            "Mod4+Shift+3" = "move container to workspace number 3";
            "Mod4+Shift+4" = "move container to workspace number 4";
            "Mod4+Shift+5" = "move container to workspace number 5";
            "Mod4+Shift+6" = "move container to workspace number 6";
            "Mod4+Shift+7" = "move container to workspace number 7";
            "Mod4+Shift+8" = "move container to workspace number 8";
            "Mod4+Shift+9" = "move container to workspace number 9";
          };
          fonts = {
            names = ["Source Code Pro"];
            size = 13.0;
          };
        };
      };
    })
  ];
}
