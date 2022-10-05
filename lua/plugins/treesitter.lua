--========================================================================
-- Neovim stable (version 0.8)
-- Treesitter configuration
--========================================================================
require("nvim-treesitter.configs").setup {

    -- Treesitter based syntax highlighting
    highlight = {
        enable = true, -- if false WHOLE extension is disabled!!!

        additional_vim_regex_highlighting = false,
    },

    -- Required treesitter parsers
    ensure_installed = {
        "lua", "python", "c", "typescript", "vim",
    },

    sync_install = true, -- install parsers synchronously

    -- Settings for nvim-ts-rainbow module
    rainbow = {
      enable = true,
      extended_mode = true, --> highlight non bracket delimiters (eg. html tags)
      max_file_lines = nil, --> do not use for files > N lines
      -- colors = {}, --> table of hex strings
      -- termcolors = {}, --> table of color name strings
    },
}
