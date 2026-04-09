local M = {}

function M.setup()
  local ok, blink = pcall(require, "blink.cmp")
  if not ok then
    return
  end

  blink.setup({
    keymap = {
      preset = "default",
      ["<C-n>"] = { "select_next", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<C-y>"] = { "accept", "fallback" },
    },
    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
      menu = {
        draw = {
          columns = {
            { "label", "label_description" },
            { "source_name" },
          },
          components = {
            source_name = {
              text = function(ctx)
                local source_names = {
                  LSP = "lsp",
                  Buffer = "buffer",
                  Path = "path",
                  Snippets = "snippets",
                }

                local source = source_names[ctx.source_name] or string.lower(ctx.source_name)
                return "[" .. source .. "]"
              end,
            },
          },
        },
      },
    },
  })
end

return M
