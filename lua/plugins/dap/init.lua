-- Dap config
local dap = require("dap")
local dap_ui = require("dap.ui.widgets")

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
