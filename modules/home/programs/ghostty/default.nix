{
  config,
  lib,
  pkgs,
  ...
}: {
  options.my.home.programs.ghostty.enable = lib.mkEnableOption "ghostty terminal";

  config = lib.mkIf config.my.home.programs.ghostty.enable {
    programs.ghostty = {
      enable = true;
      settings = {
        command = "${pkgs.zsh}/bin/zsh -l";
        font-family = "JetBrains Mono";
        font-size = 13.5;
        window-decoration = "server";
        title = "Ghostty";
        auto-update = "off";
      };
    };
  };
}
