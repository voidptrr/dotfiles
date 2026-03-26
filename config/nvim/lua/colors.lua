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
      return {
        User1 = { bg = "#000000", fg = colors.palette.waveAqua2 },
        User2 = {
          bg = "#000000",
          fg = colors.palette.dragonYellow,
        },
        User3 = { bg = "#000000", fg = colors.theme.ui.fg },
        User4 = { bg = "#000000", fg = colors.theme.ui.fg },
        User5 = { bg = "#000000", fg = colors.palette.waveRed },
      }
    end,
  })

  vim.cmd.colorscheme("kanagawa")
end

setup_statusline()
setup_kanagawa()
