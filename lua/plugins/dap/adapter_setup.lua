local dap_ok, dap = pcall(require, "dap")

if not dap_ok then
  print("nvim-dap is not installed")
  return
end

-- LLDB: C, C++, Rust
dap.adapters.lldb = {
  type = "executable",
  command = "/usr/bin/lldb",
  name = "lldb",
}

local lldb = {
  name = "Launch LLDB",
  type = "lldb",
  request = "launch",
  program = function()
    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
  end,
  cwd = "${workspaceFolder}",
  stopOnEntry = false,
  args = {},
  runOnTerminal = false,
}

dap.configurations.rust = { lldb }

-- Python (debugpy)
local dap_python_ok, dap_python = pcall(require, "dap-python")
if dap_python_ok then
  dap_python.setup("$HOME/.virtualenvs/debugpy/bin/python")
  table.insert(dap.configurations.python, {
    type = "python",
    request = "launch",
    name = "Launch Debugpy",
    program = "${file}",
  })
end

-- Lua (OSV: one-small-step-for-vimkind)
dap.configurations.lua = {
  {
    type = 'nlua',
    request = 'attach',
    name = "Attach to running Neovim instance",
    host = function()
      local value = vim.fn.input('Host [127.0.0.1]: ')
      if value ~= "" then
        return value
      end
      return '127.0.0.1'
    end,
    port = function()
      local val = tonumber(vim.fn.input('Port: '))
      assert(val, "Using default port 8086")
      return val
    end,
  }
}

dap.adapters.nlua = function(callback, config)
  callback({ type = "server", host = config.host or '127.0.0.1',
    port = config.port or 8086 })
end
