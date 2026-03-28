vim.opt.background = "dark"
vim.opt.termguicolors = true

local function setup_statusline()
  vim.opt.statusline = table.concat({
    "%1* %n %*",
    "%5*%{&ff}%*",
    "%3*%y%*",
    "%4* %<%F%*",
    "%2*%m%*",
    "%1*%=%5l%*",
    "%2*/%L%*",
    "%1*%4v %*",
    "%2*0x%04B %*",
  })
end

local function setup_kanagawa()
  require("kanagawa").setup({
    theme = "dragon",
    transparent = false,
    background = {
      dark = "dragon",
    },
    colors = {
      theme = {
        all = {
          ui = {
            bg_gutter = "none",
          },
        },
      },
    },
    overrides = function(colors)
      local black_color = "#000000"
      return {
        Pmenu = { bg = colors.palette.sumiInk3 },
        PmenuSel = { bg = colors.palette.sumiInk4, fg = colors.palette.fujiWhite },
        PmenuKind = { bg = colors.palette.sumiInk3, fg = colors.palette.fujiWhite },
        PmenuKindSel = { bg = colors.palette.sumiInk4, fg = colors.palette.fujiWhite },
        PmenuExtra = { bg = colors.palette.sumiInk3, fg = colors.theme.ui.fg_dim },
        PmenuExtraSel = { bg = colors.palette.sumiInk4, fg = colors.theme.ui.fg_dim },
        PmenuSbar = { bg = colors.palette.sumiInk2 },
        PmenuThumb = { bg = colors.palette.waveBlue2 },
        User1 = { bg = black_color, fg = colors.palette.waveAqua2 },
        User2 = { bg = black_color, fg = colors.palette.dragonYellow },
        User3 = { bg = black_color, fg = colors.theme.ui.fg },
        User4 = { bg = black_color, fg = colors.theme.ui.fg },
        User5 = { bg = black_color, fg = colors.palette.waveRed },
      }
    end,
  })

  vim.cmd.colorscheme("kanagawa")
end

setup_statusline()
setup_kanagawa()
