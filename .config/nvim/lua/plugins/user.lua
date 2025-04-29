return {
  "lewis6991/gitsigns.nvim",
  "lewis6991/satellite.nvim",
  "nvim-lualine/lualine.nvim",
  "andweeb/presence.nvim",
  {
    "sphamba/smear-cursor.nvim",
    opts = { -- Default  Range
      legacy_computing_symbols_support = true,
      -- stiffness = 0.8, -- 0.6      [0, 1]
      -- trailing_stiffness = 0.5, -- 0.4      [0, 1]
      -- stiffness_insert_mode = 0.6, -- 0.4      [0, 1]
      -- trailing_stiffness_insert_mode = 0.6, -- 0.4      [0, 1]
      -- distance_stop_animating = 0.5, -- 0.1      > 0
    },
  },
  {
    "ggandor/leap.nvim",
    init = function()
      require("leap").add_default_mappings()
    end,
    dependencies = {
      "tpope/vim-repeat"
    },
    lazy=false
  },
  {
    "kylechui/nvim-surround",
    version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      -- configuration options...
    },
  },
  {
    "Pocco81/auto-save.nvim",
    config = function() require("auto-save").setup() end,
  },
  {
    "sindrets/diffview.nvim",
    event = "BufRead",
  },
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
    opts = {
      -- Your options go here
      name = { "venv", ".venv" },
      stay_on_this_version = true,
      -- auto_refresh = false
    },
    event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
    keys = {
      -- Keymap to open VenvSelector to pick a venv.
      { "<leader>vs", "<cmd>VenvSelect<cr>" },
      -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
      { "<leader>vc", "<cmd>VenvSelectCached<cr>" },
    },
  },
}
