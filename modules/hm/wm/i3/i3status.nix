{
  lib,
  config,
  osConfig,
  ...
}: let
  i3 = osConfig.nixos.windowManager.i3;
  repoPath = "${config.home.homeDirectory}/git/dotfiles";
in {
  config = lib.mkIf (i3.enable && i3.usei3Status) {
    xdg.configFile."i3status" = {
      source = config.lib.file.mkOutOfStoreSymlink "${repoPath}/config/i3status";
      recursive = true;
    };
  };
}
