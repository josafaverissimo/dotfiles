vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local keymap = vim.keymap
    local lsp = vim.lsp
    local bufopts = { noremap = true, silent = true }

    keymap.set("n", "gr", lsp.buf.references, bufopts)
    keymap.set("n", "gd", lsp.buf.definition, bufopts)
    keymap.set("n", "gl", vim.diagnostic.open_float, bufopts)
    keymap.set("n", "K", lsp.buf.hover, bufopts)
    keymap.set("n", "<leader>lf", function()
      vim.lsp.buf.format({ async = true })
    end, bufopts)
  end
})
