{...}: {
  flake.homeManagerModules.vim = {
    config,
    pkgs,
    ...
  }: let
    repoPath = "${config.home.homeDirectory}/git/dotfiles";
  in {
    programs.vim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [vim-fugitive];
      extraConfig = ''
        source ~/.vim/vimrc
      '';
    };

    home.file.".vim" = {
      source = config.lib.file.mkOutOfStoreSymlink "${repoPath}/config/.vim";
      recursive = true;
    };
  };
}
