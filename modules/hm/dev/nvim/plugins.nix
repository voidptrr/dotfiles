{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.hm.dev.vim;
in {
  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      extraPlugins = with pkgs.vimPlugins; [
        vim-fugitive
      ];

      plugins.treesitter = {
        enable = true;
        highlight.enable = true;
        grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
          rust
          cpp
          zig
          json
          typescript
        ];
      };

      plugins.lsp = {
        enable = true;
        keymaps = {
          silent = true;
          lspBuf = {
            "<leader>lc" = "code_action";
            "K" = "hover";
            "<leader>ld" = "definition";
            "<leader>lr" = "references";
          };
        };
        servers = {
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
            package = null;
          };
          clangd = {
            enable = true;
            package = null;
          };
          zls = {
            enable = true;
            package = null;
          };
          ts_ls = {
            enable = true;
            package = null;
          };
        };
      };
    };
  };
}
