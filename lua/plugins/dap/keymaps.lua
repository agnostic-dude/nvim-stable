local dap = prequire("dap")
local widgets = prequire("dap.ui.widgets")
local variables = prequire("dap.ui.variables")

local function nmap(lhs, rhs)
	local opts = { remap = false }
	vim.keymap.set("n", lhs, rhs, opts)
end

nmap("<Leader>cc", function() dap.continue() end)
nmap("<Leader>br", function() dap.toggle_breakpoint() end)
