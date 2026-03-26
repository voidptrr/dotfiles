local ok, _ = pcall(require, "nvim-treesitter")
if not ok then
  return
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "rust", "c", "cpp", "nix", "lua" },
  callback = function()
    vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo[0][0].foldmethod = "expr"
    vim.wo[0][0].foldlevel = 99
    vim.treesitter.start()
  end,
})
