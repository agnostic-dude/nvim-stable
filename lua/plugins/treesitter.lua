--=============================================================================
-- Neovim Nightly Edtion (version 0.8)
-- Treesitter configuration
--=============================================================================
-- NOTE: Make sure treesitter is installed under "../site/pack/packer/start/"
-- not "../site/pack/packer/opt/". If that happens neovim will fail to find
-- nvim-treesitter.configs
require("nvim-treesitter.configs").setup {
  --> Parsers I need
  ensure_installed = {
    "lua", "python", "c", "typescript", "vim",
  },
  sync_install = true, --> install parsers synchronously

  highlight = {
    enable = true, --> If false WHOLE EXTENSION is disabled!

    -- If true, ":h syntax" & "tree-sitter" will run at the same time, editor
    -- may slow down and some highlights may be duplicated. Unless you depend
    -- on "syntax=enable" keep it as false!
    additional_vim_regex_highlighting = false,
  },
  -- Settings for nvim-ts-rainbow module
  rainbow = {
    enable = true,
    extended_mode = true, --> highlight non bracket delimiters (eg. html tags)
    max_file_lines = nil, --> do not use for files > N lines
    -- colors = {}, --> table of hex strings
    -- termcolors = {}, --> table of color name strings
  },
}
