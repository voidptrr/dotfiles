{
  lib,
  config,
  pkgs,
  ...
}: {
  options.my.home.programs.alacritty.enable = lib.mkEnableOption "alacritty terminal";

  config = lib.mkIf config.my.home.programs.alacritty.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        colors = {
          bright = {
            black = "0x414868";
            blue = "0x7aa2f7";
            cyan = "0x7dcfff";
            green = "0x9ece6a";
            magenta = "0xbb9af7";
            red = "0xf7768e";
            white = "0xc0caf5";
            yellow = "0xe0af68";
          };

          cursor = {
            cursor = "0xc0caf5";
            text = "0x1a1b26";
          };

          normal = {
            black = "0x15161e";
            blue = "0x7aa2f7";
            cyan = "0x7dcfff";
            green = "0x9ece6a";
            magenta = "0xbb9af7";
            red = "0xf7768e";
            white = "0xa9b1d6";
            yellow = "0xe0af68";
          };

          primary = {
            background = "0x1a1b26";
            foreground = "0xc0caf5";
          };
        };

        font = {
          size = 7.5;
          normal.family = "Noto Sans Mono";
        };

        keyboard.bindings = [
          {
            action = "Paste";
            key = "V";
            mods = "Alt";
          }
          {
            action = "Copy";
            key = "C";
            mods = "Alt";
          }
          {
            chars = "—";
            key = "—";
            mods = "Alt";
          }
          {
            chars = "—";
            key = "—";
            mods = "Shift | Alt";
          }
          {
            chars = "æ";
            key = "æ";
            mods = "Alt";
          }
          {
            chars = "Æ";
            key = "æ";
            mods = "Shift | Alt";
          }
          {
            chars = "ø";
            key = "ø";
            mods = "Alt";
          }
          {
            chars = "Ø";
            key = "ø";
            mods = "Shift | Alt";
          }
          {
            chars = "å";
            key = "å";
            mods = "Alt";
          }
          {
            chars = "Å";
            key = "å";
            mods = "Shift | Alt";
          }
        ];

        scrolling.history = 0;

        terminal.shell = {
          program = "${pkgs.zsh}/bin/zsh";
          args = ["-l"];
        };

        window.decorations = "full";
      };
    };
  };
}
