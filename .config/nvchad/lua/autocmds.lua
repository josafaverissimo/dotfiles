require "nvchad.autocmds"

local function clear_cmdarea()
  vim.defer_fn(function()
    vim.api.nvim_echo({}, false, {})
  end, 800)
end

vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  callback = function()
    local name = vim.api.nvim_buf_get_name(0)
    local buftype = vim.bo.buftype

    if name ~= "" and buftype == "" and vim.bo.buflisted then
      vim.schedule(function()
        vim.cmd "silent w"

        local time = os.date "%I:%M %p"

        vim.api.nvim_echo({
          { "󰄳", "LazyProgressDone" },
          { " file autosaved at " .. time },
        }, false, {})
        clear_cmdarea()
      end)
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "TelescopePrompt",
  callback = function()
    local opts = { noremap = true, silent = true, buffer = true }
    vim.keymap.set("n", ":", "<C-c>:", opts)
    vim.keymap.set("i", "jj", "<Esc>", opts)
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
  callback = function()
    vim.lsp.codelens.refresh()
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client and client.server_capabilities.semanticTokensProvider then
      client.server_capabilities.semanticTokensProvider = nil
    end

    vim.schedule(function()
      pcall(vim.cmd, "TSBufEnable highlight")
    end)
  end,
})
