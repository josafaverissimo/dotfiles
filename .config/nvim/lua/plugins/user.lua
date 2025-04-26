return {
  "lewis6991/gitsigns.nvim",
  "lewis6991/satellite.nvim",
  "nvim-lualine/lualine.nvim",
  "andweeb/presence.nvim",
  "nvim-java/nvim-java",
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      -- configuration options...
    }
  },
  {
    "Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup()
    end,
  },
  {
    "sindrets/diffview.nvim",
    event = "BufRead",
  },
  {
    'linux-cultist/venv-selector.nvim',
    dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python' },
    opts = {
      -- Your options go here
      name = { "venv", ".venv" },
      stay_on_this_version = true
      -- auto_refresh = false
    },
    event = 'VeryLazy', -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
    keys = {
      -- Keymap to open VenvSelector to pick a venv.
      { '<leader>vs', '<cmd>VenvSelect<cr>' },
      -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
      { '<leader>vc', '<cmd>VenvSelectCached<cr>' },
    },
  },
}
