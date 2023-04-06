local M = {}

-- Keymappings to launch lazygit
Nnoremap("<Leader><Space>", "<cmd>LazyGit<cr>")



-- Track all git repos visited in one nvim session
local lazygit_ok, lazygit = pcall(require, "lazygit")

if lazygit_ok then
  -- track any open vim buffer contained in a git repository
  vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    callback = function()
      require("lazygit.utils").project_root_dir()
    end,
  })
  M = lazygit
else
  vim.notify("Need to install lazygit.nvim")
end

return M
