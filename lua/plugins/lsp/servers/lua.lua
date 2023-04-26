-------------------------------------------------------------------------------
-- Lua Language Servers
-------------------------------------------------------------------------------
local servers = {}

if vim.fn.executable("lua-language-server") then
  servers.lua_ls = {
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using
          -- (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
          -- path = vim.o.runtimepath,
        },
        diagnostics = {
          globals = { "vim" }, -- Get LSP server to recognize the `vim` global
        },
        workspace = {
          -- Make the server aware of Neovim runtime files,
          -- see also https://github.com/LuaLS/lua-language-server/wiki/Libraries#link-to-workspace
          -- Lua-dev.nvim also has similar settings for lua ls,
          -- https://github.com/folke/neodev.nvim/blob/main/lua/neodev/luals.lua
          library = {
            -- vim.fn.stdpath("data") .. "/site/pack/packer/opt/emmylua-nvim",
            vim.fn.stdpath("config"),
          },
          checkThirdParty = false,
          maxPreload = 2000,
          preloadFileSize = 50000,
        },
        telemetry = { enable = false },
        callSnippet = "Replace",
      },
    },
  }
end

return servers
