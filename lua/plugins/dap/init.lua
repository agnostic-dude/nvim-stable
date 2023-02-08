-- Dap config
local dap = require("dap")

-- Keymappings
Nnoremap("<M-b>", dap.toggle_breakpoint) -- toggle BREAKPOINT

Nnoremap("<M-c>", function() -- CONTINUE
  dap.continue()
  vim.notify("continuing to next breakpoint", vim.log.levels.INFO)
end)
Nnoremap("<F2>", function() -- STEP OVER
  dap.step_over()
  vim.notify("stepping over", vim.log.levels.INFO)
end)
Nnoremap("<F3>", function() -- STEP INTO
  dap.step_into()
  vim.notify("stepping into", vim.log.levels.INFO)
end)
Nnoremap("<F4>", function() -- STEP OUT
  dap.step_out()
  vim.notify("stepping out", vim.log.levels.INFO)
end)
-- Launch lua debugger
Nnoremap("<Leader>dL", function() require("osv").launch({ port = 8086 }) end)
Nnoremap("<Leader>du", require("dap.ui.widgets").hover)

-- Setting up DAP-UI
local dapui_ok, dapui = pcall(require, "dapui")
if dapui_ok then
  dapui.setup()
  Nnoremap("<Leader>do", dapui.open)
  Nnoremap("<Leader>dc", dapui.close)
  Nnoremap("<Leader>dt", dapui.toggle)
else
  vim.notify_once("Need to install nvim-dap-ui")
end

-- use nvim-dap events to open and close windows automatically
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- Setting up DAP virtual text
require("nvim-dap-virtual-text").setup()

-------------------------------------------------------------------------------
-- Configs for individual debuggers
-------------------------------------------------------------------------------

-- Golang/Delve
dap.configurations.go = {
  {
    type = "delve",
    name = "Debug",
    request = "launch",
    program = "${file}",
  },
  {
    type = "delve",
    name = "Debug test",
    request = "launch",
    mode = "test",
    program = "${file}",
  },
  {
    type = "delve",
    name = "Debug test (go.mod)",
    request = "launch",
    mode = "test",
    program = "./${relativeFileDirname}",
  },
}

dap.adapters.delve = {
  type = "server",
  port = "${port}",
  executable = {
    command = "node",
    args = { "dap", "-l", "127.0.0.1:${port}" },
  }
}

require("dap-go").setup()

dap.configurations.lua = {
  type = "nlua",
  request = "attach",
  name = "Attach to running neovim instance",
}

dap.adapters.nlua = function(callback, config)
  callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
end
