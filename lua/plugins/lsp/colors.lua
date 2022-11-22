--=============================================================================
-- Neovim stable (version 0.8)
-- lsp-colors configuration: automatically create missing highlight groups for
-- colorschemes that do not yet support builtin LSP client
--=============================================================================

local lsp_colors = prequire("lsp-colors")
if lsp_colors then
    lsp_colors.setup({
        Error = "#db4b4b",
        Warning = "#e0af68",
        Information = "#0db9d7",
        Hint = "#10b981",
    })
end
