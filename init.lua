--=============================================================================
-- Neovim Stable (version 0.8)
-- Main configuration
--=============================================================================

require("user.settings")
require("user.utils")
require("user.keymaps")
require("user.autocommands")
require("user.colors")
require("user.plugins")
require("user.viml")

require("plugins.nvim_tree")
require("plugins.treesitter")
require("plugins.indentblankline")
require("plugins.toggleterm")
require("plugins.gitsigns")
require("plugins.colorizer")
require("plugins.telescope")
require("plugins.devicons")

-- Setup all LSP related plugins by sourcing lua/plugins/lsp/init.lua
require("plugins.lsp")

-- Setup DAP related plugins
require("plugins.dap")

-- require("plugins.dap.adapter_setup")
-- require("plugins.dap.dapui")
-- require("plugins.dap.keymaps")
-- require("plugins.dap.virtual_text")
