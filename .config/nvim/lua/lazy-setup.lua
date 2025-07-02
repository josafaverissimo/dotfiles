local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins_spec = {}
local plugins = {
  'blink',
  'catppuccin',
  'lualine',
  'mason',
  'mason-lspconfig',
  'neo-tree',
  'nvim-telescope',
  'nvim-treesitter',
  'nvim-jdtls',
  'which-key',
  'winshift',
  'nvim-ts-context-commentstring'
}

for _, plugin in ipairs(plugins) do
  table.insert(plugins_spec, require('plugins.' .. plugin))
end


require("lazy").setup(plugins_spec)
