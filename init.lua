--=============================================================================
-- Neovim Stable (version 0.8)
-- Main configuration
--=============================================================================

require("user.settings")
require("user.utils")
require("user.keymaps")
require("user.autocommands")
require("user.plugins")
require("user.viml")

-- Setup all LSP related plugins by sourcing lua/plugins/lsp/init.lua
require("plugins.lsp")

-- Setup DAP related plugins
require("plugins.dap")
