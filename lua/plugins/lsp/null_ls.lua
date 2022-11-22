#!/usr/bin/env lua
-- Configuration for NULL-LS

local null_ls = prequire("null-ls")
if null_ls then
    null_ls.setup {
        sources = {
            -- General
            null_ls.builtins.formatting.codespell, -- find common misspellings
            null_ls.builtins.hover.dictionary, -- show first available definition for word under cursor

            -- refactoring library based on Refactoring book by Martin Fowler
            -- requires visually selecting the code needing refactoring and
            -- calling :'<,'>lua vim.lsp.buf.range_code_action() for default
            -- calling :'<,'>Telescope lsp_range_code_actions for Telescope
            null_ls.builtins.code_actions.refactoring,

            -- diagnostic warnings on lines with TODO comments (Lua + treesitter)
            null_ls.builtins.diagnostics.todo_comments,

            -- Snippets
            null_ls.builtins.completion.luasnip,


            -- * C/C++
            null_ls.builtins.diagnostics.clang_check, -- syntax check on save
            null_ls.builtins.formatting.clang_format,

            -- * Python
            null_ls.builtins.formatting.black,
            null_ls.builtins.diagnostics.flake8, -- check quality & style
            null_ls.builtins.diagnostics.pylama, -- code audit tool wraps pycodestyle, pydocstyle, pyflakes, mccabe, pylint, radon, eradicate, mypy, vulture
            null_ls.builtins.formatting.isort, -- sort & categorize imports

            -- * Lua
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.diagnostics.luacheck, -- lint & static analysis

            -- * Shell scripting
            null_ls.builtins.diagnostics.shellcheck,
            null_ls.builtins.diagnostics.zsh, -- zsh -n option, like a basic linter
            null_ls.builtins.formatting.beautysh, -- bash beautifier (yay)
            null_ls.builtins.formatting.shellharden, -- quote vars, modify function calls

            -- * JavaScript/TypeScript
            null_ls.builtins.formatting.eslint_d, -- find & fix problems in JS code faster
            null_ls.builtins.formatting.prettierd,

            -- * Rust
            null_ls.builtins.formatting.rustfmt, -- format according to guidelines

            -- * HTML/XML
            null_ls.builtins.formatting.tidy, -- correct & cleanup HTML/XML
        }
    }
end
