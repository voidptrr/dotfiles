{lib, ...}: {
  plugins = {
    luasnip.enable = true;
    cmp-nvim-lsp.enable = true;
    cmp-nvim-lsp-signature-help.enable = true;
    cmp-buffer.enable = true;
    cmp-path.enable = true;
    cmp_luasnip.enable = true;
    lspkind.enable = true;
    cmp = {
      enable = true;
      autoEnableSources = false;
      settings = {
        snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
        mapping = {
          "<C-b>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-y>" = "cmp.mapping.confirm({ select = true })";
          "<C-n>" = "cmp.mapping.select_next_item()";
          "<C-p>" = "cmp.mapping.select_prev_item()";
        };
        sources = [
          {name = "nvim_lsp";}
          {name = "nvim_lsp_signature_help";}
          {name = "path";}
          {
            name = "buffer";
            keyword_length = 2;
          }
        ];
        formatting.format = lib.mkForce (lib.nixvim.mkRaw ''
          require('lspkind').cmp_format({
            with_text = true,
            menu = {
              nvim_lsp = '[LSP]', path = '[path]',
              buffer = '[buf]'
            }
          })
        '');
        window.documentation = {
          border = "rounded";
        };
        performance = {
          debounce = 100;
          throttle = 100;
          fetching_timeout = 250;
        };
      };
    };
  };
}
