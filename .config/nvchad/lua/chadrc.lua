-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.disable = {
  n = {
    ["<Tab>"] = "",
    ["<S-Tab>"] = "",
  },
  v = {
    ["<Tab>"] = "",
    ["<S-Tab>"] = "",
  },
  i = {
    ["<Tab>"] = "<Tab>", -- mantém comportamento de inserir tab no insert
    ["<S-Tab>"] = "<S-Tab>",
  },
}

M.base46 = {
  theme = "catppuccin",
  transparency = true,

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
}

M.nvdash = {
  load_on_startup = true,
  header = {
    [[       /\\       ]],
    [[      /  \\      ]],
    [[     /    \\     ]],
    [[    /__--__\\    ]],
    [[   /   ,,   \\   ]],
    [[  /   |  |   \\  ]],
    [[ /_-''    ''-_\\ ]],
    [[                 ]],
    [[  Powered By  eovim ]],
    [[                 ]],
  },
}

M.ui = {
  tabufline = {
    lazyload = false,
  },

  statusline = {
    separator_style = "block",
  },

  telescope = {
    style = "bordered",
  },
}

return M
