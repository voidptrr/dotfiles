if vim.fn.exists(":Git") ~= 2 then
  return
end

vim.keymap.set("n", "<leader>gs", "<cmd>Git<CR>", { silent = true })
vim.keymap.set("n", "<leader>gm", "<cmd>Git commit<CR>", { silent = true })
vim.keymap.set("n", "<leader>gp", "<cmd>Git push<CR>", { silent = true })
vim.keymap.set("n", "<leader>gP", "<cmd>Git pull<CR>", { silent = true })
vim.keymap.set(
  "n",
  "<leader>gl",
  "<cmd>Git log --oneline --decorate --graph<CR>",
  { silent = true }
)
vim.keymap.set("n", "<leader>gD", "<cmd>Gvdiffsplit<CR>", { silent = true })
