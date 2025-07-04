local map = vim.keymap.set
local builtin = require "telescope.builtin"
local actions = require("telescope.actions")

map("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
map("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
map("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
map("n", "<leader>fg", builtin.git_status, { desc = "Telescope git status" })
map("n", "<leader>fc", builtin.git_commits, { desc = "Telescope git commits" })
map("n", "<leader>fr", builtin.lsp_references, { desc = "Telescope lsp references" })
map("n", "<leader>fd", builtin.diagnostics, { desc = "Telescope diagnostics" })

require("telescope").setup{
  defaults = {
    mappings = {
      i = {
        ["<C-u>"] = false,
      },
    },
  }
}

