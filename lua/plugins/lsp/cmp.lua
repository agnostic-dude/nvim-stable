-- Load snippets from "friendly-snippets" using LuaSnip snippets engine
require("luasnip.loaders.from_vscode").lazy_load()

vim.opt.completeopt = { "menu", "menuone", "noselect" }

local cmp = require("cmp")
local luasnip = require("luasnip")
local select_opts = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  sources = {
    { name = "path" },
    { name = "nvim_lsp", keyword_length = 3 },
    { name = "buffer", keyword_length = 3 },
    { name = "luasnip", keyword_length = 2 },
  },
  window = {
    documentation = cmp.config.window.bordered()
  },
  formatting = {
    fields = { "menu", "abbr", "kind" },
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = "🖳 ",
        luasnip = "✀ ",
        buffer = "🗐 ����",
        path = "🖪 ",
      }
      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
  mapping = {
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    ["<up>"] = cmp.mapping.select_prev_item(select_opts),
    ["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
    ["<down>"] = cmp.mapping.select_next_item(select_opts),
    ["<C-n>"] = cmp.mapping.select_next_item(select_opts),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.abort(),
    -- Jump to next PLACEHOLDER in the snippet
    ["<C-j>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),
    -- Jump to previous PLACEHOLDER in the snippet
    ["<C-k>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    -- Autocomplete with TABS
    -- If completion menu is visible, move to next item. If line is empty insert
    -- a TAB character. If cursor is inside a word, trigger the completion menu.
    ["<Tab>"] = cmp.mapping(function(fallback)
      local col = vim.fn.col(".") - 1
      if cmp.visible() then
        cmp.select_next_item(select_opts)
      elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item(select_opts)
      else
        fallback()
      end
    end, { "i", "s" }),
  }
})

-- nice symbols ⍟ ⍮ ⎈ ⎊ ⍰ ⓘ   ⛭   ✂  ✄ ✮  🐛

-- Changing diagnostic icons
local function change_dignostic_sign(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = "",
  })
end

change_dignostic_sign({ name = "DiagnosticSignError", text = "🕱 " })
change_dignostic_sign({ name = "DiagnosticSignHint", text = "🌣 " })
change_dignostic_sign({ name = "DiagnosticSignInfo", text = "🛈 " })
change_dignostic_sign({ name = "DiagnosticSignWarn", text = "⚠" })
