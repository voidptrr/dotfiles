local ok, telescope = pcall(require, "telescope")
if not ok then
  return
end

local utils = require("utils")
local theme_config = require("telescope.themes").get_ivy()

telescope.setup({
  defaults = theme_config,
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
})

pcall(telescope.load_extension, "fzf")

local builtin = require("telescope.builtin")
utils.map("n", "<leader>ff", builtin.find_files)
utils.map("n", "<leader>fg", builtin.git_files)
