--=============================================================================
-- Neovim Stable (version 0.8)
-- Settings for configured language servers
--=============================================================================
-- Custom settings for all of configured language servers
local servers = {
  tsserver = {},
  pyright = {},
  clangd = {},
  vimls = {},
  gopls = {},
  tailwindcss = {},

  -- Lua
  lua_ls = {
    Lua = {
      diagnostics = {
        globals = { "vim" }, -- Get LSP to recognize "vim" global
      },
      workspace = {
        -- make server aware of neovim runtime files
        library = vim.api.nvim_get_runtime_file(".", true),
        checkThirdParty = false,
      },
      runtime = {
        version = "LuaJIT", -- Tell LSP which Lua version you're using
        path = vim.o.runtimepath,
      },
      telemetry = { enable = false },
      completion = {
        callSnippet = "Replace"
      },
    },
  },

  -- Rust
  rust_analyzer = {
    imports = {
      granularity = {
        group = "module",
      },
      prefix = "self",
    },
    cargo = {
      buildScripts = {
        enable = true,
      },
    },
    procMacro = {
      enable = true,
    },
    checkOnSave = {
      command = "clippy",
    },
  },
}

return servers
