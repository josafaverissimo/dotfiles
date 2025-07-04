require "nvchad.options"

vim.opt.relativenumber = true
vim.opt.colorcolumn = "80,120"
vim.opt.wrap = false

vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevel = 99 -- mostra tudo aberto por padrão
