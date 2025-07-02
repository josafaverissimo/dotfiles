return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	lazy = false,
	build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "tsx",
      "python",
      "javascript",
      "typescript",
      "html",
      "css",
      "scss",
      "vue"
    }
  }
}
