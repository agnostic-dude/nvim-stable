--=============================================================================
-- Neovim Stable (version 0.8)
-- Main configuration
--=============================================================================

require("user.settings")
require("user.utils")
require("user.keymap")
require("user.autocommands")
require("user.plugins")
require("user.viml")

-- Setup language server (LSP server-client communication)
require("plugins.lsp") -- source lua/plugins/lsp/init.lua

-- Setup debugger (Debugger-Debug adapter-DAP client)
require("plugins.dap")
