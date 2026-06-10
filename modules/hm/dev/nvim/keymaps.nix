{
  lib,
  config,
  ...
}: let
  cfg = config.hm.dev.vim;
in {
  config = lib.mkIf cfg.enable {
    programs.nixvim.keymaps = [
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w><C-h>";
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w><C-l>";
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w><C-j>";
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w><C-k>";
      }
      {
        mode = "n";
        key = "<leader>d";
        action = ":copen<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "-";
        action = ":Ex<CR>";
      }
      {
        mode = "n";
        key = "<leader>gs";
        action = ":Git<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>gm";
        action = ":Git commit<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>gp";
        action = ":Git push<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>gP";
        action = ":Git pull<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>gl";
        action = ":Git log --oneline --decorate --graph<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>gD";
        action = ":Gvdiffsplit<CR>";
        options.silent = true;
      }
    ];
  };
}
