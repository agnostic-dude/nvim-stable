-- Set lualine as the statusline
-- See: `:help lualine.txt`
local lualine_ok, lualine = pcall(require, "lualine")
if lualine_ok then
  lualine.setup({
    options = {
      icons_enabled = false,
      theme = "papercolor_light",
      component_separators = "┊",
      section_separators = "",
    },
  })
end
