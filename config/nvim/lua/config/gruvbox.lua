vim.opt.background = "dark"
vim.opt.termguicolors = true

require("gruvbox").setup({
  contrast = "hard",
  italic = {
    strings = false,
  },
  overrides = {
    SignColumn = { bg = "NONE" },
    CursorLineSign = { bg = "NONE" },
  },
})

vim.cmd.colorscheme("gruvbox")

for _, hl in ipairs({
  "DiagnosticSignError",
  "DiagnosticSignWarn",
  "DiagnosticSignHint",
  "DiagnosticSignInfo",
}) do
  local current = vim.api.nvim_get_hl(0, { name = hl, link = false })
  vim.api.nvim_set_hl(0, hl, { fg = current.fg, bg = "NONE" })
end
