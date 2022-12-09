-- Keymappings for DAP
local dap = require("dap")

nnoremap(",c", dap.continue)
nnoremap(",b", dap.toggle_breakpoint)
nnoremap("<F2>", dap.step_over)
nnoremap("<F3>", dap.step_into)
nnoremap("<F4>", dap.step_out)
nnoremap("<Leader>dL", function() require("osv").launch({ port = 8086 }) end)
