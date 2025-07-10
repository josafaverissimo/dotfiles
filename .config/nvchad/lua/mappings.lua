require "nvchad.mappings"

-- add yours here
local map = vim.keymap.set
local nomap = vim.keymap.del

map("i", "jk", "<ESC>")
map("n", "gl", vim.diagnostic.open_float, { desc = "diagnostic" })
map("n", "<A-k>", ":m-2<CR>", { desc = "Move line to up" })
map("n", "<A-j>", ":m+1<CR>", { desc = "Movel line to down" })
map("n", "<leader>la", vim.lsp.buf.code_action, { desc = "LSP code action" })

map("n", "<leader>bc", function()
  vim.cmd "%bd | e# | bd#"
end, { desc = "Close all and keep current buffer" })

map("n", "<leader>q", function()
  vim.cmd "wa | qa"
end, { desc = "Save and close all buffers" })

map("n", "<leader>gg", function()
  local buf = vim.api.nvim_create_buf(false, true)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = math.floor(vim.o.columns * 0.8),
    height = math.floor(vim.o.lines * 0.8),
    row = math.floor(vim.o.lines * 0.1),
    col = math.floor(vim.o.columns * 0.1),
    style = "minimal",
    border = "rounded",
  })

  vim.fn.jobstart({ "lazygit" }, {
    term = true,
    cwd = vim.loop.cwd(),
    on_exit = function(_, _)
      if vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
      end
    end,
    stdout_buffered = true,
    buffer = buf,
  })

  vim.cmd "startinsert"
end, { desc = "Open LazyGit in float" })

map({ "v", "n" }, "<S-h>", "<Nop>")
map({ "v", "n" }, "<S-l>", "<Nop>")
map({ "n", "i", "v", "c", "t" }, "<C-z>", "<Nop>", { noremap = true, silent = true })

nomap("n", "<leader>n")
nomap("n", "<leader>b")

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
