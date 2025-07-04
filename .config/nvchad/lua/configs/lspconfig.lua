require("nvchad.configs.lspconfig").defaults()

local servers = {
  html = {},
  cssls = {},
  ts_ls = {},
  jdtls = {},
  gopls = {},
  biome = {}
}

for name, opts in pairs(servers) do
  vim.lsp.enable(name)
  vim.lsp.config(name, opts)
end

-- read :h vim.lsp.config for changing options of lsp servers 
