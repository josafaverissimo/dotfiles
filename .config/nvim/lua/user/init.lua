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
    "tailwindcss"
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
