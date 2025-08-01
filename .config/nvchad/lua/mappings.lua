require "nvchad.mappings"
local tabufline = require "nvchad.tabufline"

-- add yours here
local map = vim.keymap.set
local nomap = vim.keymap.del
local renamer = require "nvchad.lsp.renamer"

map("i", "jk", "<ESC>")
map("n", "gl", vim.diagnostic.open_float, { desc = "diagnostic" })
map("n", "<A-k>", ":m-2<CR>", { desc = "Move line to up" })
map("n", "<A-j>", ":m+1<CR>", { desc = "Movel line to down" })
map("n", "<leader>la", vim.lsp.buf.code_action, { desc = "LSP code action" })
map("n", "<C-Right>", ":vertical resize +5<CR>", { desc = "Vertical Resize" })
map("n", "<C-Left>", ":vertical resize -5<CR>", { desc = "Vertical Resize" })
map("n", "<C-Up>", ":resize +5<CR>", { desc = "horizontal Resize" })
map("n", "<C-Down>", ":resize -5<CR>", { desc = "Horizontal Resize" })
map("n", "grn", renamer, { desc = "Horizontal Resize" })

map("n", "<leader>bc", function()
  -- vim.cmd "%bd | e# | bd#"

  tabufline.closeAllBufs(false)
end, { desc = "Close all and keep current buffer" })

map("n", "<leader>bl", function()
  tabufline.closeBufs_at_direction("left")
end, { desc = "Close all in right" })

map("n", "<leader>br", function()
  tabufline.closeBufs_at_direction("right")
end, { desc = "Close all in left" })

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
