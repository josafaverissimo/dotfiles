  require "nvchad.autocmds"

vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
  pattern = "*",
  callback = function()
    if vim.bo.modifiable and vim.bo.buftype == "" and vim.fn.getbufvar("%", "&modified") == 1 then
      vim.cmd("silent! write")
    end
  end,
})
