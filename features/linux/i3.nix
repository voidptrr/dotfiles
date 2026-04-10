{config, ...}: let
  repoPath = "${config.home.homeDirectory}/git/dotfiles";
in {
  xdg.configFile."i3" = {
    source = config.lib.file.mkOutOfStoreSymlink "${repoPath}/config/i3";
    recursive = true;
  };

  xdg.configFile."polybar" = {
    source = config.lib.file.mkOutOfStoreSymlink "${repoPath}/config/polybar";
    recursive = true;
  };
}
