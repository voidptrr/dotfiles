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
        font-family = "Source Code Pro";
        font-size = 13;
        theme = "Kanagawa Dragon";
        window-decoration = "server";
        working-directory = "home";
        window-inherit-working-directory = false;
      };
    };
  };
}
