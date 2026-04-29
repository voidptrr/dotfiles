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
              border = "#c4b28a";
              background = "#000000";
              text = "#c4b28a";
              indicator = "#c4b28a";
              childBorder = "#c4b28a";
            };
            unfocused = {
              border = "#808080";
              background = "#000000";
              text = "#808080";
              indicator = "#808080";
              childBorder = "#808080";
            };
            focusedInactive = {
              border = "#8a9a7b";
              background = "#000000";
              text = "#8a9a7b";
              indicator = "#8a9a7b";
              childBorder = "#8a9a7b";
            };
            urgent = {
              border = "#c4746e";
              background = "#000000";
              text = "#c4746e";
              indicator = "#c4746e";
              childBorder = "#c4746e";
            };
          };
          bars = [
            {
              position = "top";
              statusCommand = "i3status";
              trayOutput = "primary";
              fonts = {
                names = ["JetBrains Mono"];
                size = 13.0;
              };
              colors = {
                background = "#000000";
                statusline = "#8a9a7b";
                separator = "#808080";
                focusedWorkspace = {
                  border = "#c4b28a";
                  background = "#000000";
                  text = "#c4b28a";
                };
                activeWorkspace = {
                  border = "#8a9a7b";
                  background = "#000000";
                  text = "#8a9a7b";
                };
                inactiveWorkspace = {
                  border = "#000000";
                  background = "#000000";
                  text = "#808080";
                };
                urgentWorkspace = {
                  border = "#c4746e";
                  background = "#000000";
                  text = "#c4746e";
                };
                bindingMode = {
                  border = "#c4746e";
                  background = "#000000";
                  text = "#c4746e";
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
            names = ["JetBrains Mono"];
            size = 13.0;
          };
        };
      };
    })
  ];
}
