{
  lib,
  pkgs,
  config,
  ...
}: let
  repoPath = "${config.home.homeDirectory}/git/dotfiles";
in {
  options.hm.dev.vim.enable = lib.mkEnableOption "vim";

  config = lib.mkIf config.hm.dev.vim.enable {
    programs.vim = {
      enable = true;
      plugins = [pkgs.vimPlugins.vim-fugitive];
      extraConfig = ''
        source ~/.config/vim/vimrc
      '';
    };

    xdg.configFile."vim" = {
      source = config.lib.file.mkOutOfStoreSymlink "${repoPath}/config/vim";
      recursive = true;
    };
  };
}
