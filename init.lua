--=============================================================================
-- Neovim Stable (version 0.8)
-- Configuration file in Lua
--=============================================================================
--
require("user.settings")
require("user.keymaps")
require("user.autocommands")
require("user.plugins")
require("user.colors")

require("plugins.treesitter")
require("plugins.indentblankline")
require("plugins.toggleterm")

require("plugins.lsp.server_setup")
require("plugins.lsp.keymaps")
require("plugins.lsp.cmp")
