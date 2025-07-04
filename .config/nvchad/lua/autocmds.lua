require "nvchad.autocmds"

vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    if vim.bo.modifiable and vim.bo.buftype == "" then
      vim.cmd("silent! write")
    end
  end,
})
