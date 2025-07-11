local telescope = require "telescope"
local mason_dap = require "mason-nvim-dap"
local map = vim.keymap.set
local dap = require "dap"
local ui = require "dapui"
local dap_virtual_text = require "nvim-dap-virtual-text"
local home = os.getenv "HOME"
local mason_path = home .. "/.local/share/nvim/mason"
local js_dap_debug_server = mason_path .. "/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"

-- Dap Virtual Text
dap_virtual_text.setup()

dap.set_log_level "DEBUG"

mason_dap.setup {
  ensure_installed = { "java-debug-adapter" },
  automatic_installation = true,
  handlers = {
    function(config)
      require("mason-nvim-dap").default_setup(config)
    end,
  },
}

dap.adapters = {
  ["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = 9229,
    executable = {
      command = "node",
      args = { js_dap_debug_server, "9229" },
    },
  },
}

-- Configurations
dap.configurations = {
  java = {
    {
      type = "java",
      name = "Debug file",
      request = "launch",
      program = "${file}",
    },
  },
  typescript = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file (Deno)",
      runtimeExecutable = "deno",
      runtimeArgs = {
        "run",
        "--inspect-wait",
        "--allow-all",
      },
      program = "${file}",
      cwd = "${workspaceFolder}",
      attachSimplePort = 9229,
    },
  },
}

-- Dap UI

ui.setup()

vim.fn.sign_define("DapBreakpoint", { text = "🐞" })

dap.listeners.before.attach.dapui_config = function()
  ui.open()
end
dap.listeners.before.launch.dapui_config = function()
  ui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  ui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  ui.close()
end

-- Debugger Keymaps
map("n", "<leader>dt", function()
  require("dap").toggle_breakpoint()
end, { desc = "Toggle Breakpoint" })

map("n", "<leader>dc", function()
  require("dap").continue()
end, { desc = "Continue" })

map("n", "<leader>di", function()
  require("dap").step_into()
end, { desc = "Step Into" })

map("n", "<leader>do", function()
  require("dap").step_over()
end, { desc = "Step Over" })

map("n", "<leader>du", function()
  require("dap").step_out()
end, { desc = "Step Out" })

map("n", "<leader>dr", function()
  require("dap").repl.open()
end, { desc = "Open REPL" })

map("n", "<leader>dl", function()
  require("dap").run_last()
end, { desc = "Run Last" })

map("n", "<leader>dq", function()
  require("dap").terminate()
  require("dapui").close()
  require("nvim-dap-virtual-text").toggle()
end, { desc = "Terminate" })

map("n", "<leader>db", telescope.extensions.dap.list_breakpoints, { desc = "List Breakpoints" })

map("n", "<leader>de", function()
  require("dap").set_exception_breakpoints { "all" }
end, { desc = "Set Exception Breakpoints" })
