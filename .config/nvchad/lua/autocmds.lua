require "nvchad.autocmds"

vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
  pattern = "*",
  callback = function()
    if vim.bo.modifiable and vim.bo.buftype == "" and vim.fn.getbufvar("%", "&modified") == 1 then
      vim.cmd "silent! write"
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "TelescopePrompt",
  callback = function()
    local opts = { noremap = true, silent = true, buffer = true }
    -- Mapear ':' para abrir a linha de comando no Telescope prompt
    vim.keymap.set("n", ":", "<C-c>:", opts)
    -- Mapear 'jj' para sair do modo insert no Telescope prompt
    vim.keymap.set("i", "jj", "<Esc>", opts)
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
  callback = function()
    vim.lsp.codelens.refresh()
  end,
})
