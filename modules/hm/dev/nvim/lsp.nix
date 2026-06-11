{
  lib,
  config,
  ...
}: let
  cfg = config.hm.dev.vim;
in {
  config = lib.mkIf cfg.enable {
    programs.nixvim.plugins.lsp = {
      enable = true;
      preConfig = ''
        vim.lsp.semantic_tokens.enable(false)
      '';
      keymaps = {
        silent = true;
        diagnostic = {
          "<leader>d" = "setqflist";
        };
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
}
