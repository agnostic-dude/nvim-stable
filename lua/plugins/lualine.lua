-- Set lualine as the statusline
-- See: `:help lualine.txt`
local lualine_ok, lualine = pcall(require, "lualine")
if lualine_ok then
  lualine.setup({
    options = {
      icons_enabled = true,
      theme = "auto",
      component_separators = "┆",
      section_separators = "",
      disabled_filetypes = { "NvimTree" },
    },
  })
end
