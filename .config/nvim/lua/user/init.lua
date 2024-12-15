vim.keymap.set('n', '<A-k>', ':m-2<CR>')
vim.keymap.set('n', '<A-j>', ':m+1<CR>')
vim.keymap.set('n', '<leader>nb', ':Neotree buffers<CR>')
vim.keymap.set('n', '<leader>ng', ':Neotree git_status<CR>')

require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = {
    "volar",
    "ts_ls",
    "pyright",
    "ruff",
    "tailwindcss",
    "rust_analyzer"
  },
  automatic_installation = true,
})

require('lspconfig').ruff.setup({
  init_options = {
    settings = {
      lineLength = 120,
      lint = {
        preview = true,
        select = { "E", "W", "N", "PL" },
      },
    },
  }
})

require('nvim-treesitter.configs').setup({
  ensure_installed = {
    "python",
    "javascript",
    "typescript",
    "html",
    "css",
    "scss",
    "vue"
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
})

local MASON_PACKAGE_PATH = vim.fn.expand('~/.local/share/nvim/mason/packages')
local VOLAR_TS_PLUGIN = MASON_PACKAGE_PATH .. '/vue-language-server/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin'
local TS_PATH = MASON_PACKAGE_PATH .. '/typescript-language-server/node_modules/typescript/lib'

require('lspconfig').volar.setup({
  init_options = {
    typescript = {
      tsdk = TS_PATH
    }
  }
})

require('lspconfig').ts_ls.setup({
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = VOLAR_TS_PLUGIN,
        languages = {'javascript', 'typescript', 'vue'}
      },
    }
  },
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
    'vue',
  },
})

-- set rulers
vim.opt.colorcolumn = "80,120"

-- Remove useless spaces
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

-- Configuração do LSP para rust-analyzer (Rust)
require('lspconfig').rust_analyzer.setup({
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true
      },
      procMacro = {
        enable = true
      }
    }
  }
})

-- Setup do DAP (debugger) para Rust utilizando codelldb
local dap = require'dap'
local codelldb_path = MASON_PACKAGE_PATH .. '/codelldb/extension/adapter/codelldb'

dap.adapters.codelldb = {
  type = 'server',
  port = 13000,  -- Porta para a comunicação com o codelldb
  executable = {
    command = codelldb_path,
    args = {'--port', '13000'},
  },
}

dap.configurations.rust = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
  },
}
