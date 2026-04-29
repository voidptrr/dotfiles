{
  lib,
  config,
  osConfig,
  ...
}: let
  i3 = osConfig.nixos.windowManager.i3;
  repoPath = "${config.home.homeDirectory}/git/dotfiles";
in {
  imports = [
    ./i3status.nix
  ];

  config = lib.mkMerge [
    {
      assertions = [
        {
          assertion = !i3.usei3Status || i3.enable;
          message = "nixos.windowManager.i3.usei3Status requires nixos.windowManager.i3.enable";
        }
      ];
    }

    (lib.mkIf i3.enable {
      xdg.configFile."i3" = {
        source = config.lib.file.mkOutOfStoreSymlink "${repoPath}/config/i3";
        recursive = true;
      };
    })
  ];
}
