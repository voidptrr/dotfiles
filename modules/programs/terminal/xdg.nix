{...}: {
  registry.homeManagerModules.xdg = {config, ...}: let
    repoPath = "${config.home.homeDirectory}/git/dotfiles";
    xdgDirs = [
      "ghostty"
      "opencode"
      "tmux"
    ];
  in {
    xdg.configFile = builtins.listToAttrs (
      map (dir: {
        name = dir;
        value = {
          source = config.lib.file.mkOutOfStoreSymlink "${repoPath}/config/${dir}";
          recursive = true;
        };
      })
      xdgDirs
    );
  };
}
