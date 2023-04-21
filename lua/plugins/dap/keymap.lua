-- Keymappings for DAP
local dap = require("dap")

Nnoremap(",c", dap.continue)
Nnoremap(",b", dap.toggle_breakpoint)
Nnoremap("<F2>", dap.step_over)
Nnoremap("<F3>", dap.step_into)
Nnoremap("<F4>", dap.step_out)
Nnoremap("<Leader>dL", function() require("osv").launch({ port = 8086 }) end)
