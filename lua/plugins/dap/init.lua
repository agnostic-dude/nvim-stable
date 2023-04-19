-- Dap config
-- This is the only file neovim uses
local dap = require("dap")

-- Keymappings
Nnoremap("<M-b>", dap.toggle_breakpoint) -- toggle BREAKPOINT

Nnoremap("<M-c>", function() -- CONTINUE
  dap.continue()
  vim.notify("continuing to next breakpoint", vim.log.levels.INFO, {
    title = "nvim-dap-config"
  })
end)
Nnoremap("<F2>", function() -- STEP OVER
  dap.step_over()
  vim.notify("stepping over", vim.log.levels.INFO, {
    title = "nvim-dap-config"
  })
end)
Nnoremap("<F3>", function() -- STEP INTO
  dap.step_into()
  vim.notify("stepping into", vim.log.levels.INFO, {
    title = "nvim-dap-config"
  })
end)
Nnoremap("<F4>", function() -- STEP OUT
  dap.step_out()
  vim.notify("stepping out", vim.log.levels.INFO, {
    title = "nvim-dap-config"
  })
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
  vim.notify("Need to install nvim-dap-ui", {
    title = "nvim-dap-config"
  })
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

-- Lua/nlua
dap.configurations.lua = {
  type = "nlua",
  request = "attach",
  name = "Attach to running neovim instance",
  port = function()
    return tonumber(vim.fn.input("Port: "))
  end,
}

dap.adapters.nlua = function(callback, config)
  callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
end

-- Python/Debugpy
local dap_python_ok, dap_python = pcall(require, "dap-python")
if dap_python_ok then
  dap_python.setup("~/.virtualenvs/debugpy/bin/python")
end

-- source: https://www.reddit.com/r/neovim/comments/u014b4/a_convenient_python_dap_configuration/
dap.configurations.python = dap.configurations.python or {}
table.insert(dap.configurations.python, {
  type = "python",
  request = "launch",
  name = "launch with options",
  program = "${file}",
  python = function() end,
  pythonPath = function()
    local path
    for _, server in pairs(vim.lsp.get_active_clients()) do
      path = vim.tbl_get(server, "config", "settings", "python", "pythonPath")
      if path then
        break
      end
    end
    path = vim.fn.input("Python path: ", path or "", "file")
    return path ~= "" and vim.fn.expand(path) or nil
  end,

  args = function()
    local args = {}
    local i = 1
    while true do
      local arg = vim.fn.input("Argument [" .. i .. "]: ")
      if arg == "" then
        break
      end
      args[i] = arg
      i = i + 1
    end
    return args
  end,
  justMyCode = function()
    return vim.fn.input("justMyCode? [y/n]: ") == "y"
  end,
  stopOnEntry = function()
    return vim.fn.input("justMyCode? [y/n]: ") == "y"
  end,
  console = "integratedTerminal",
})

-- C/C++/Rust (with lldb-vscode)
dap.adapters.lldb = {
  type = "executable",
  command = "/usr/share/bin/lldb-vscode",
  name = "lldb",
}

dap.configurations.c = {
  name = "Launch",
  type = "lldb-vscode",
  request = "launch",
  program = function()
    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
  end,
  cwd = "${workspaceFolder}",
  stopOnEntry = false,
  args = {},
}

dap.configurations.rust = dap.configurations.c
