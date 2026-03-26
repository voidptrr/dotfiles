{...}: {
  flake.homeManagerModules.nvim = {
    config,
    pkgs,
    ...
  }: let
    repoPath = "${config.home.homeDirectory}/git/dotfiles";
    neovimWithPlugins = pkgs.neovim.override {
      configure = {
        customRC = ''
          lua dofile(vim.fn.expand("~/.config/nvim/init.lua"))
        '';
        packages.main = with pkgs.vimPlugins; {
          start = [
            vim-fugitive
            (nvim-treesitter.withPlugins (plugins:
              with plugins; [
                c
                cpp
                lua
                nix
                rust
              ]))
            kanagawa-nvim
            telescope-nvim
            telescope-fzf-native-nvim
          ];
        };
      };
    };
  in {
    home.packages = [neovimWithPlugins];
    xdg.configFile."nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "${repoPath}/config/nvim";
      recursive = true;
    };
  };
}
