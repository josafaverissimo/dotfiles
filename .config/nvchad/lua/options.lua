require "nvchad.options"

vim.opt.relativenumber = true
vim.opt.colorcolumn = "80,120"

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

vim.opt.wrap = false
