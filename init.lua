--========================================================================
-- Neovim Stable (version 0.8)
-- Configuration file in Lua
--========================================================================

require("user.settings")
require("user.utils")
require("user.keymaps")
require("user.autocommands")
require("user.plugins")
require("user.colors")
require('user.viml')

require("plugins.toggleterm")
require("plugins.treesitter")
require("plugins.lualine")
require("plugins.indentblankline")
require("plugins.gitsigns")
require("plugins.telescope")
require("plugins.alpha")

require("plugins.lsp.setup")
require("plugins.lsp.diagnostics")
require("plugins.lsp.keymaps")
require("plugins.lsp.nvim_cmp")
require("plugins.lsp.colors")
require("plugins.lsp.trouble")
require("plugins.lsp.null_ls")

-- require "plugins.dap_config"
-- require("plugins.dbg")
-- require("plugins.dbg.config")
-- require("plugins.dbg.keymaps")
-- require("plugins.dbg.ui")

-- require "plugins.refactoring"
-- TODO: need setup DAP in a separate directory like lsp
require("plugins.dap")
