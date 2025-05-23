local function copy_path()
  local path = vim.fn.expand('%:p')

  if path == '' then
    print("Nenhum arquivo aberto no buffer atual.")
    return
  end

  vim.fn.setreg('+', path)

  print("Path copiado para o clipboard: " .. path)
end
vim.api.nvim_create_user_command('CopyPath', copy_path, {})
