-------------------------------------------------------------------------------
-- Python Language Servers
-------------------------------------------------------------------------------
local servers = {}

if vim.fn.executable("pylsp") then
  servers.pylsp = {
    setting = {
      pylsp = {
        plugins = {
          pylint = { enabled = true, executable = "pylint" },
          pyflakes = { enabled = false },
          pycodestyle = { enabled = false },
          jedi_completion = { fuzzy = true },
          pyls_isort = { enabled = true },
          pylsp_mypy = { enabled = true },
        },
      },
    },
    flags = {
      debounce_text_changes = 200,
    },
  }
else
  vim.notify("python-language-server not found!", WARN, { title = "Lspconfig" })
end

if vim.fn.executable("pyright") then
  servers.pyright  = {
    -- empty config table
  }
else
  vim.notify("pyright not found!", WARN, { title = "Lspconfig" })
end

return servers
