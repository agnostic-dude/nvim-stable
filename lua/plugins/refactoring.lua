--========================================================================
-- Neovim Stable (version 0.8)
-- Configuration file in Lua
-- TODO: Complete setting this up
--========================================================================
prequire("refactoring").setup({
	prompt_func_return_type = {
		cpp = true,
		c = true,
		h = false,
		hpp = false,
		cxx = false,
	},
	prompt_func_param_type = {
		cpp = true,
		c = true,
		h = false,
		hpp = false,
		cxx = false,
	},
        printf_statements = {},
        print_var_statements = {},
})
