{
  config,
  lib,
  osConfig,
  ...
}: let
  repoPath = "${config.home.homeDirectory}/git/dotfiles";
  i3 = osConfig.nixos.windowManager.i3;
in {
  config = lib.mkIf i3.enable {
    xdg.configFile =
      {
        "i3/config" = {
          source = config.lib.file.mkOutOfStoreSymlink "${repoPath}/config/i3/config";
        };
      }
      // lib.optionalAttrs i3.usei3Status {
        "i3status/config" = {
          source = config.lib.file.mkOutOfStoreSymlink "${repoPath}/config/i3status/config";
        };
      };
  };
}
