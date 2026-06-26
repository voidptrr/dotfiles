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
        font-size = 14.5;
        theme = "Gruvbox Material Dark";
        background = "#0f1112";
        window-decoration = "server";
        working-directory = "home";
        window-inherit-working-directory = false;
      };
    };
  };
}
