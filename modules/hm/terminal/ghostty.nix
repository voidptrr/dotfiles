{
  osConfig,
  lib,
  config,
  ...
}: let
  p = osConfig.nixos.theme.palette;
  themeName = osConfig.nixos.theme.name;
  variant = osConfig.nixos.theme.variant;
  ghosttyTheme =
    if themeName == "kanagawa" && variant == "dragon"
    then "Kanagawa Dragon"
    else null;
in {
  options.hm.terminal.ghostty.enable = lib.mkEnableOption "ghostty terminal";

  config = lib.mkIf config.hm.terminal.ghostty.enable {
    assertions = [
      {
        assertion = osConfig.nixos.theme.enable;
        message = "hm.terminal.ghostty.enable requires nixos.theme.enable";
      }
    ];

    programs.ghostty = {
      enable = true;
      settings =
        {
          font-family = "Source Code Pro";
          font-size = 13;
          window-decoration = "server";
          working-directory = "home";
          window-inherit-working-directory = false;
        }
        // lib.optionalAttrs (ghosttyTheme != null) {
          theme = ghosttyTheme;
        };
    };
  };
}
