-- Dap config
local dap = require("dap")
local dap_ui = require("dap.ui.widgets")

Nnoremap("<C-b>", dap.toggle_breakpoint)
Nnoremap("<C-a>", dap.continue)
Nnoremap("<F2>", dap.step_over)
Nnoremap("<F3>", dap.step_into)
Nnoremap("<F4>", dap.step_out)
Nnoremap("<Leader>dL", function() require("osv").launch({ port = 8086 }) end)
Nnoremap("<Leader>du", dap_ui.hover)


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

require("dap-go").setup({
  on_attach = function()
    -- code
  end
})

dap.configurations.lua = {
  type = "nlua",
  request = "attach",
  name = "Attach to running neovim instance",
}

dap.adapters.nlua = function(callback, config)
  callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
end
