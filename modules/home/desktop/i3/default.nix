{
  lib,
  config,
  osConfig,
  ...
}: let
  i3 = osConfig.my.nixos.desktop.i3;
  repoPath = "${config.home.homeDirectory}/git/dotfiles";
in {
  options.my.home.desktop.i3.enable = lib.mkEnableOption "i3 user configuration";

  config = lib.mkMerge [
    {
      assertions = [
        {
          assertion = !i3.usei3Status || i3.enable;
          message = "my.nixos.desktop.i3.usei3Status requires my.nixos.desktop.i3.enable";
        }
      ];
    }

    (lib.mkIf (config.my.home.desktop.i3.enable && i3.enable) {
      xdg.configFile."i3" = {
        source = config.lib.file.mkOutOfStoreSymlink "${repoPath}/config/i3";
        recursive = true;
      };
    })

    (lib.mkIf (config.my.home.desktop.i3.enable && i3.enable && i3.usei3Status) {
      xdg.configFile."i3status" = {
        source = config.lib.file.mkOutOfStoreSymlink "${repoPath}/config/i3status";
        recursive = true;
      };
    })
  ];
}
