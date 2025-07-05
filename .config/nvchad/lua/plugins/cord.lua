return {
  "vyfor/cord.nvim",
  event = "BufReadPost",
  config = function()
    require("cord").setup {}
  end,
}
