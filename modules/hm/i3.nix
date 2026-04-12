{
  config,
  lib,
  osConfig,
  ...
}: let
  repoPath = "${config.home.homeDirectory}/git/dotfiles";
  i3 = osConfig.nixos.windowManager.i3;
in {
  config =
    (lib.mkIf i3.enable {
      xdg.configFile."i3" = {
        source = config.lib.file.mkOutOfStoreSymlink "${repoPath}/config/i3";
        recursive = true;
      };
    })
    // (lib.mkIf (i3.enable && i3.usei3Status) {
      xdg.configFile."i3status" = {
        source = config.lib.file.mkOutOfStoreSymlink "${repoPath}/config/i3status";
        recursive = true;
      };
    });
}
