require("nvchad.configs.lspconfig").defaults()

local servers = {
  "html",
  "cssls",
  "ts_ls",
  "jdtls",
  "lua_ls",
  "gopls",
  "biome"
}
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
