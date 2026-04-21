{...}: {
  programs.nixvim = {
    plugins.web-devicons.enable = false;

    plugins.telescope = {
      enable = true;
      extensions = {
        "fzf-native".enable = true;
      };
      keymaps = {
        "<leader>ff" = {
          action = "find_files";
          options.silent = true;
        };
        "<leader>fg" = {
          action = "git_files";
          options.silent = true;
        };
      };

      settings = {
        defaults = {
          layout_strategy = "bottom_pane";
        };

        pickers = {
          find_files = {
            theme = "ivy";
          };
          git_files = {
            theme = "ivy";
          };
        };
      };
    };
  };
}
