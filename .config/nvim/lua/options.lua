

vim.opt.clipboard = 'unnamedplus'
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
vim.opt.mouse = 'a'

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.showmode = true

vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.wrap = false

vim.cmd('highlight YankHighlight guibg=#ffdd55 guifg=black')
vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'YankHighlight',
      timeout = 100,
    })
  end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    if vim.bo.modifiable and vim.bo.buftype == "" then
      vim.cmd("silent! write")
    end
  end,
})

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

