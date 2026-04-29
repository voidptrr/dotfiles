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
        font-family = "JetBrains Mono SemiBold";
        font-size = 13.5;
        theme = "Ghostty Default Style Dark";
        window-decoration = "server";
        working-directory = "home";
        window-inherit-working-directory = false;
      };
    };
  };
}
