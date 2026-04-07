local opt = vim.opt
local utils = require("utils")

-- Search
opt.ignorecase = true
opt.smartcase = true

-- UI
opt.number = true
opt.signcolumn = "yes"
opt.mouse = "a"
opt.cursorline = true
opt.scrolloff = 10
opt.completeopt = "menuone,noselect,popup"

-- Editing
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.breakindent = true
opt.backspace = "indent,start,eol"
opt.confirm = true

-- Performance and undo
opt.updatetime = 250
opt.undofile = true

-- File handling
opt.backup = false
opt.writebackup = false

-- Window splitting
opt.splitbelow = true
opt.splitright = true

-- Keymaps
utils.map("n", "<Esc>", "<cmd>nohlsearch<CR>")
utils.map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
utils.map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
utils.map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
utils.map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
utils.map("n", "-", vim.cmd.Ex)
