local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  local actions = require "telescope.actions"
  local action_state = require "telescope.actions.state"

  local view_selection = function(prompt_bufnr)
    actions.select_default:replace(function()
      actions.close(prompt_bufnr)
      local selection = action_state.get_selected_entry()
      local filename = selection.filename
      if filename == nil then
        filename = selection[1]
      end
      api.tree.find_file(filename, { open = true, focus = true })
      api.node.open.preview()
    end)
    return true
  end

  local function launch_telescope(func_name, ops)
    local telescope_status_ok, _ = pcall(require, "telescope")
    if not telescope_status_ok then
      return
    end
    local node = api.tree.get_node_under_cursor()
    local basedir = node.type == "directory" and node.absolute_path or vim.fn.fnamemodify(node.absolute_path, ":h")
    ops = ops or {}
    ops.cwd = basedir
    ops.search_dirs = { basedir }
    ops.attach_mappings = view_selection
    return require("telescope.builtin")[func_name](ops)
  end

  local function launch_live_grep(ops)
    return launch_telescope("live_grep", ops)
  end

  local function launch_find_files(ops)
    return launch_telescope("find_files", ops)
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  local function edit_or_open()
    local node = api.tree.get_node_under_cursor()

    if node.nodes ~= nil then
      -- expand or collapse folder
      api.node.open.edit()
    else
      -- open file
      api.node.open.edit()
      -- Close the tree if file was opened
      api.tree.close()
    end
  end

  -- open as vsplit on current node
  local function vsplit_preview()
    local node = api.tree.get_node_under_cursor()

    if node.nodes ~= nil then
      -- expand or collapse folder
      api.node.open.edit()
    else
      -- open file as vsplit
      api.node.open.vertical()
    end

    -- Finally refocus on tree if it was lost
    api.tree.focus()
  end

  -- custom mappings
  vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts "Up")
  vim.keymap.set("n", "<C-h>", api.tree.toggle_help, opts "Help")
  vim.keymap.set("n", "l", edit_or_open, opts "Edit Or Open")
  vim.keymap.set("n", "L", vsplit_preview, opts "Vsplit Preview")
  vim.keymap.set("n", "h", api.tree.close, opts "Close")
  vim.keymap.set("n", "H", api.tree.collapse_all, opts "Collapse All")
  vim.keymap.set("n", "j", "j^", opts "Down")
  vim.keymap.set("n", "k", "k^", opts "Up")
  vim.keymap.set("n", "<leader>ff", launch_find_files, opts "Launch Find Files")
  vim.keymap.set("n", "<leader>fw", launch_live_grep, opts "Launch Live Grep")

  vim.keymap.set("n", "<C-e>", "<C-e>", { buffer = bufnr, noremap = true, silent = true, nowait = true })
end

-- pass to setup along with your other options
require("nvim-tree").setup {
  on_attach = my_on_attach,
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
}
