vim.api.nvim_create_user_command("Rename", function(opts)
  local new_file = opts.args

  if new_file == "" then
    print("Usage: :Rename <new_filename>")
    return
  end

  vim.cmd("sav %:h/" .. new_file .. " | bd# | !rm #:p")
end, { desc = "Rename current buffer and file", nargs = 1, complete = "file" })
