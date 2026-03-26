local M = {}

---@alias Utils.Mode string|string[]
---@alias Utils.Rhs string|function

---@param mode Utils.Mode
---@param lhs string
---@param rhs Utils.Rhs
---@param opts? vim.keymap.set.Opts
---@return nil
function M.map(mode, lhs, rhs, opts)
  local keymap_opts = vim.tbl_extend("force", { silent = true }, opts or {})
  return vim.keymap.set(mode, lhs, rhs, keymap_opts)
end

---@param event string|string[]
---@param opts vim.api.keyset.create_autocmd
---@return integer
function M.autocmd(event, opts)
  local autocmd_opts = vim.tbl_extend("force", {}, opts)

  if type(autocmd_opts.group) == "string" then
    local clear = autocmd_opts.clear
    autocmd_opts.group = vim.api.nvim_create_augroup(autocmd_opts.group, {
      clear = clear ~= false,
    })
    autocmd_opts.clear = nil
  end

  return vim.api.nvim_create_autocmd(event, autocmd_opts)
end

return M
