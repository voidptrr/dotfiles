local servers = {
    "lua_ls",
    "nil_ls",
    "rust_analyzer",
}

require("plugins.lsp").setup(servers)
