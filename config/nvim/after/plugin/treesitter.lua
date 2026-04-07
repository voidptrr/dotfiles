local ft_to_lang = {
  c = "c",
  lua = "lua",
  nix = "nix",
  rust = "rust",
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = vim.tbl_keys(ft_to_lang),
  callback = function(ev)
    local filetype = vim.bo[ev.buf].filetype
    local lang = ft_to_lang[filetype]
    if not lang then
      return
    end

    local ok = vim.treesitter.language.add(lang)
    if not ok then
      return
    end

    vim.treesitter.start(ev.buf, lang)
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo.foldmethod = "expr"
    vim.wo.foldlevel = 99
  end,
})
