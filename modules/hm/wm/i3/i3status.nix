{
  lib,
  osConfig,
  ...
}: let
  i3 = osConfig.nixos.windowManager.i3;
in {
  config = lib.mkIf (i3.enable && i3.usei3Status) {
    programs.i3status = {
      enable = true;
      enableDefault = false;

      general = {
        output_format = "i3bar";
        markup = "pango";
        colors = true;
        interval = 2;
        color_good = "#8a9a7b";
        color_bad = "#c4746e";
        color_degraded = "#c4b28a";
      };

      modules = {
        "tztime local" = {
          position = 1;
          settings = {
            format = "<span color='#c4b28a'>%Y-%m-%d %H:%M</span>";
          };
        };

        "volume master" = {
          position = 2;
          settings = {
            format = "VOL %volume";
            format_muted = "VOL muted";
            device = "default";
            mixer = "Master";
            mixer_idx = 0;
          };
        };

        "battery all" = {
          position = 3;
          settings = {
            format = "BAT %status %percentage";
            format_down = "BAT %status %percentage";
            status_chr = "+";
            status_bat = "";
            status_full = "full";
            low_threshold = 15;
            integer_battery_capacity = true;
            hide_seconds = true;
          };
        };

        "wireless _first_" = {
          position = 4;
          settings = {
            format_up = "WIFI %quality";
            format_down = "WIFI down";
          };
        };

        "cpu_usage" = {
          position = 5;
          settings = {
            format = "CPU %usage";
          };
        };

        "memory" = {
          position = 6;
          settings = {
            format = "MEM %percentage_used";
            threshold_degraded = "50%";
            format_degraded = "MEM %percentage_used";
          };
        };
      };
    };
  };
}
