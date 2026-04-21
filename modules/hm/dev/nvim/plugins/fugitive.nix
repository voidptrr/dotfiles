{...}: {
  programs.nixvim = {
    plugins.fugitive.enable = true;

    keymaps = [
      {
        mode = "n";
        key = "<leader>gs";
        action = "<cmd>Git<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>gm";
        action = "<cmd>Git commit<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>gp";
        action = "<cmd>Git push<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>gP";
        action = "<cmd>Git pull<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>gl";
        action = "<cmd>Git log --oneline --decorate --graph<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>gD";
        action = "<cmd>Gvdiffsplit<CR>";
        options.silent = true;
      }
    ];
  };
}
