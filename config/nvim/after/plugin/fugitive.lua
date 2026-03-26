if vim.fn.exists(":Git") ~= 2 then
  return
end

local function setup_fugitive()
  local utils = require("utils")
  local map = utils.map

  map("n", "<leader>gs", "<cmd>Git<CR>")
  map("n", "<leader>gm", "<cmd>Git commit<CR>")
  map("n", "<leader>gp", "<cmd>Git push<CR>")
  map("n", "<leader>gP", "<cmd>Git pull<CR>")
  map("n", "<leader>gl", "<cmd>Git log --oneline --decorate --graph<CR>")
  map("n", "<leader>gD", "<cmd>Gvdiffsplit<CR>")
end

setup_fugitive()
