--=========================================================================
-- Neovim Stable (version 0.8)
-- nvim-cmp configuration: smart autocompletion
--=========================================================================
-- TODO: re-write config with prequire() instead of require()
local cmp = require "cmp"
local luasnip = require "luasnip"
local lspkind = require "lspkind"
local select_opts = { select = cmp.SelectBehavior.Select }

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    sources = cmp.config.sources({
        { name = "path" }, -- autocomplete file paths
        { name = "nvim_lsp", keyword_length = 3 }, -- based on server responses
        { name = "buffer", keyword_length = 3 }, -- based on current buffer
        { name = "luasnip", keyword_length = 2 }, -- based on available snips
    }),
    window = {
        documentation = cmp.config.window.bordered(),
        completion = cmp.config.window.bordered(),
    },
    formatting = {
        fields = { "menu", "abbr", "kind" },
        format = lspkind.cmp_format({
            mode = "symbol",
            maxwidth = 50,
            ellipsis_char = "...",
            before = function(entry, item)
                -- Show Devicons as kind (only use of lspkind.nvim plugin)
                -- The function below will be called before any actual
                -- modification from lspkind, so that you can provide more
                -- controls on pop-up
                -- (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
                if vim.tbl_contains({ "path" }, entry.source.name) then
                    local icon, hl_group = require("nvim-web-devicons")
                        .get_icon(entry:get_completion_item().label)
                    if icon then
                        item.kind = icon
                        item.kind_hl_group = hl_group
                        return item
                    end
                    return lspkind.cmp_format({ with_text = false })(entry, item)
                else
                    local menu_icon = {
                        nvim_lsp = "🖥", -- " 🖧  🖳  "
                        buffer = "🗏", -- 🖹
                        path = "🗂",
                        luasnip = "✀",
                    }
                    item.menu = menu_icon[entry.source.name]
                    return item
                end
            end,
        })
    },
    ---- KEYMAPPINGS TO WORK WITH SNIPPETS ----
    mapping = cmp.mapping.preset.insert({
        -- scroll up/down between completion items
        ["<C-n>"] = cmp.mapping.select_next_item(select_opts),
        ["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
        -- scroll text in documenation window
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4), -- <C-f>
        -- cancel completion
        ["<C-e>"] = cmp.mapping.abort(),
        -- confirm selection
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        }),
        -- jump to next placeholder in the snippet
        ["<C-j>"] = cmp.mapping(function(fallback) -- <C-d>
            if luasnip.jumpable(1) then
                luasnip.jump(1)
            else
                fallback()
            end
        end, { "i", "s" }),
        -- jump to previous placeholder in the snippet
        ["<C-k>"] = cmp.mapping(function(fallback) -- <C-b>
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
        -- Tab autocompletion
        ["<Tab>"] = cmp.mapping(function(fallback)
            local col = vim.fn.col(".") - 1
            if cmp.visible() then
                cmp.select_next_item(select_opts)
            elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
                fallback()
            else
                cmp.complete()
            end
        end, { "i", "s" }),
        -- If completion menu is visible move to next item
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item(select_opts)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
})

vim.api.nvim_create_autocmd(
    { "TextChangedI", "TextChangedP" },
    {
        callback = function()
            local line = vim.api.nvim_get_current_line()
            local cursor = vim.api.nvim_win_get_cursor(0)[2]
            local current = string.sub(line, cursor, cursor + 1)
            if current == "." or current == "," or current == " " then
                cmp.close()
            end
            local before_line = string.sub(line, 1, cursor + 1)
            local after_line = string.sub(line, cursor + 1, -1)
            if not string.match(before_line, "^%s+$") then
                if after_line == "" or string.match(before_line, " $")
                    or string.match(before_line, "%.$") then
                    cmp.complete()
                end
            end
        end,
        pattern = "*",
    }
)

-- "/" cmdline setup
cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = { { name = "buffer" } }
})

-- ":" cmdline setup
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" }
    }, {
        { name = "cmdline" }
    })
})
