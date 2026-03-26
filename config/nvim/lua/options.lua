local opt = vim.opt

opt.ignorecase = true
opt.smartcase = true
opt.number = true
opt.signcolumn = "yes"
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.mouse = "a"
opt.cursorline = true

opt.autoindent = true
opt.smartindent = true
opt.backspace = "indent,start,eol"
opt.completeopt = "menuone,noselect,popup"

opt.backup = false
opt.writebackup = false

opt.path:append("**")

opt.splitbelow = true
opt.splitright = true
