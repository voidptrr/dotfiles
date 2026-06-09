{
  lib,
  config,
  ...
}: {
  options.hm.terminal.ghostty.enable = lib.mkEnableOption "ghostty terminal";

  config = lib.mkIf config.hm.terminal.ghostty.enable {
    programs.ghostty = {
      enable = true;
      settings = {
        font-family = "Mononoki Nerd Font Mono";
        font-size = 15;
        background = "#19171d";
        foreground = "#8b8792";
        cursor-color = "#8b8792";
        cursor-text = "#19171d";
        selection-background = "#585260";
        selection-foreground = "#efecf4";
        palette = [
          "0=#19171d"
          "1=#924f58"
          "2=#5f6a9c"
          "3=#a08061"
          "4=#5d8676"
          "5=#685286"
          "6=#5f7e94"
          "7=#8b8792"
          "8=#655f6d"
          "9=#924f58"
          "10=#5f6a9c"
          "11=#a08061"
          "12=#5d8676"
          "13=#685286"
          "14=#5f7e94"
          "15=#efecf4"
        ];
        window-decoration = "server";
        working-directory = "home";
        window-inherit-working-directory = false;
      };
    };
  };
}
