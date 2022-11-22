-- How to add Visual Studio Code Dark+ theme colors to the menu?
-- source: https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance
-- gray
vim.cmd[[ highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080 ]]

-- blue
vim.cmd[[ highlight! CmpItemAbbrMatch guibg=NONE guifg=#569cd6 ]]
vim.cmd[[ highlight! link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch ]]

-- light blue
vim.cmd[[ highlight! CmpItemKindVariable guibg=NONE guifg=#9cdcfe ]]
vim.cmd[[ highlight! link CmpItemKindInterface CmpItemKindVariable ]]
vim.cmd[[ highlight! link CmpItemKindText CmpItemKindVariable ]]

-- pink
vim.cmd[[ highlight! CmpItemKindFunction guibg=NONE guifg=#c586c0 ]]
vim.cmd[[ highlight! link CmpItemKindMethod CmpItemKindFunction ]]

-- front
vim.cmd[[ highlight! CmpItemKindKeyword guibg=NONE guifg=#d4d4d4 ]]
vim.cmd[[ highlight! link CmpItemKindProperty CmpItemKindKeyword ]]
vim.cmd[[ highlight! link CmpItemKindUnit CmpItemKindKeyword ]]

require("tokyonight").setup({
    styles = {
        functions= "bold",
        keywords = "italic",
    }
})
