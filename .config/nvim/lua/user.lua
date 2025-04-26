vim.keymap.set("n", "<A-k>", ":m-2<CR>")
vim.keymap.set("n", "<A-j>", ":m+1<CR>")
vim.keymap.set("n", "<leader>nb", ":Neotree buffers<CR>")
vim.keymap.set("n", "<leader>ng", ":Neotree git_status<CR>")
vim.api.nvim_set_keymap("n", "<leader>s", [[:%s/\s\+$//e<CR>]], { noremap = true, silent = true })

vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#f38ba8" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = "#f9e2af" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = "#89b4fa" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = "#a6e3a1" })

require("mason").setup()

require("mason-lspconfig").setup {
  ensure_installed = {
    "volar",
    "ts_ls",
    "pyright",
    "ruff",
    "tailwindcss",
    "rust_analyzer",
    "biome",
    "jdtls",
  },
  automatic_installation = true,
}

require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "tsx",
    "python",
    "javascript",
    "typescript",
    "html",
    "css",
    "scss",
    "vue",
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

local MASON_PACKAGE_PATH = vim.fn.expand "~/.local/share/nvim/mason/packages"
local VOLAR_TS_PLUGIN = MASON_PACKAGE_PATH
  .. "/vue-language-server/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin"
local TS_PATH = MASON_PACKAGE_PATH .. "/typescript-language-server/node_modules/typescript/lib"

require("lspconfig").biome.setup {
  root_dir = require("lspconfig.util").root_pattern(
    "biome.json",
    "biome.jsonc",
    "biome.config.json",
    "package.json",
    ".git"
  ),
}

require("lspconfig").volar.setup {
  init_options = {
    typescript = {
      tsdk = TS_PATH,
    },
  },
}

require("lspconfig").ts_ls.setup {
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = VOLAR_TS_PLUGIN,
        languages = { "javascript", "typescript", "vue" },
      },
    },
  },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "vue",
  },
}

require("lspconfig").jdtls.setup {
  settings = {
    java = {
      project = {
        sourcePaths = { "." },
      },
    },
  },
}

-- set rulers
vim.opt.colorcolumn = "80,120"

-- Configuração do LSP para rust-analyzer (Rust)
require("lspconfig").rust_analyzer.setup {
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      procMacro = {
        enable = true,
      },
    },
  },
}

-- Setup do DAP (debugger) para Rust utilizando codelldb
local dap = require "dap"
local codelldb_path = MASON_PACKAGE_PATH .. "/codelldb/extension/adapter/codelldb"

dap.adapters.codelldb = {
  type = "server",
  port = 13000, -- Porta para a comunicação com o codelldb
  executable = {
    command = codelldb_path,
    args = { "--port", "13000" },
  },
}

dap.configurations.rust = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function() return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file") end,
  },
}
