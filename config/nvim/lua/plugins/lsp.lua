local utils = require("utils")

local M = {}

local function setup_diagnostics()
  local function diagnostics_to_quickfix()
    local quickfix_win

    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local info = vim.fn.getwininfo(win)[1]
      if info and info.quickfix == 1 then
        quickfix_win = win
        break
      end
    end

    vim.diagnostic.setqflist({ open = quickfix_win == nil })

    if quickfix_win and vim.api.nvim_win_is_valid(quickfix_win) then
      vim.api.nvim_set_current_win(quickfix_win)
    end
  end

  vim.diagnostic.config({
    virtual_text = false,
    underline = false,
    severity_sort = true,
    update_in_insert = false,
  })

  for _, hl in ipairs({
    "DiagnosticSignError",
    "DiagnosticSignWarn",
    "DiagnosticSignHint",
    "DiagnosticSignInfo",
  }) do
    local current = vim.api.nvim_get_hl(0, { name = hl, link = false })
    vim.api.nvim_set_hl(0, hl, { fg = current.fg, bg = "NONE" })
  end

  utils.map("n", "<leader>d", diagnostics_to_quickfix, {
    desc = "Diagnostics to quickfix",
  })
end

local function setup_lsp_servers()
  local servers = {
    "lua_ls",
    "nil_ls",
    "rust_analyzer",
  }

  for _, server in ipairs(servers) do
    vim.lsp.enable(server)
  end

  utils.autocmd("LspAttach", {
    group = "custom.lsp",
    callback = function(ev)
      local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
      if client:supports_method("textDocument/completion") then
        vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = false })
      end

      local opts = { buffer = ev.buf, silent = true }
      utils.map("n", "<leader>gd", vim.lsp.buf.definition, opts)
      utils.map("n", "<leader>gi", vim.lsp.buf.implementation, opts)
      utils.map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
      utils.map("n", "<leader>gr", vim.lsp.buf.references, opts)
    end,
  })
end

function M.setup()
  setup_diagnostics()
  setup_lsp_servers()
end

return M
