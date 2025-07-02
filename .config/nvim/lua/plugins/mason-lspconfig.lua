return {
	"mason-org/mason-lspconfig.nvim",
	dependencies = {
		"mason-org/mason.nvim",
		"neovim/nvim-lspconfig",
	},
	opts = {
		ensure_installed = {
		  "ts_ls",
		  "jdtls",
		  "tailwindcss",
		  "biome",
		  "gopls",
		  "pyright",
		  "lua_ls"
		},
	},
}
