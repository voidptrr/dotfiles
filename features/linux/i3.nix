{config, ...}: let
  repoPath = "${config.home.homeDirectory}/git/dotfiles";
in {
  xdg.configFile."i3" = {
    source = config.lib.file.mkOutOfStoreSymlink "${repoPath}/config/i3";
    recursive = true;
  };

  xdg.configFile."i3status" = {
    source = config.lib.file.mkOutOfStoreSymlink "${repoPath}/config/i3status";
    recursive = true;
  };
}
