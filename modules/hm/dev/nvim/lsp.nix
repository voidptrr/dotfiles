{...}: {
  programs.nixvim = {
    diagnostic.settings = {
      virtual_text = false;
      underline = false;
      severity_sort = true;
      update_in_insert = false;
    };

    plugins.lsp = {
      enable = true;
      servers = {
        nil_ls = {
          enable = true;
          package = null;
        };

        rust_analyzer = {
          enable = true;
          package = null;
          installCargo = false;
          installRustc = false;
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>gd";
        action = "definition";
      }
      {
        mode = "n";
        key = "<leader>gi";
        action = "implementation";
      }
      {
        mode = ["n" "v"];
        key = "<leader>ca";
        action = "code_action";
      }
      {
        mode = "n";
        key = "<leader>gr";
        action = "references";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>gn";
        action = "rename";
      }
      {
        mode = "n";
        key = "<leader>d";
        action = "<cmd>lua vim.diagnostic.setqflist({ open = true })<CR>";
      }
    ];
  };
}
