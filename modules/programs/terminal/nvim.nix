{...}: {
  flake.homeManagerModules.nvim = {
    config,
    pkgs,
    ...
  }: let
    repoPath = "${config.home.homeDirectory}/git/dotfiles";
    mkTsRuntime = lang: grammar:
      pkgs.runCommand "nvim-ts-${lang}" {} ''
        mkdir -p "$out/parser" "$out/queries/${lang}"
        ln -s "${grammar}/parser" "$out/parser/${lang}.so"

        if [ -d "${grammar}/queries" ]; then
          for query in "${grammar}"/queries/*.scm; do
            [ -e "$query" ] || continue
            ln -s "$query" "$out/queries/${lang}/$(basename "$query")"
          done
        fi
      '';
    tsRuntime = pkgs.symlinkJoin {
      name = "nvim-ts-runtime";
      paths = [
        (mkTsRuntime "nix" pkgs.tree-sitter-grammars.tree-sitter-nix)
        (mkTsRuntime "rust" pkgs.tree-sitter-grammars.tree-sitter-rust)
      ];
    };
    neovimWithPlugins = pkgs.neovim.override {
      configure = {
        customRC = ''
          lua vim.opt.runtimepath:append("${tsRuntime}")
          lua dofile(vim.fn.expand("~/.config/nvim/init.lua"))
        '';
        packages.main = with pkgs.vimPlugins; {
          start = [
            vim-fugitive
            kanagawa-nvim
            telescope-nvim
            telescope-fzf-native-nvim
            indent-blankline-nvim
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
