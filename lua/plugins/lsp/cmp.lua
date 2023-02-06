-- Completion options
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- From nvim-cmp wiki Example-mappings#supertab-like-mappings#luasnip
local function has_words_before()
  table.unpack = table.unpack or unpack -- avoid deprecation warning for lua>5.1
  local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
      :sub(col, col):match("%s") == nil
end

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
        buffer = "🗐 ",
        path = "🗁 ", -- 🖪

      }
      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
  mapping = {
    ["<CR>"] = cmp.mapping.confirm({
      cmp.SelectBehavior.Replace,
      select = false,
    }),
    ["<up>"] = cmp.mapping.select_prev_item(select_opts),
    ["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
    ["<down>"] = cmp.mapping.select_next_item(select_opts),
    ["<C-n>"] = cmp.mapping.select_next_item(select_opts),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
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
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }
})

-- Load snippets from "friendly-snippets" using LuaSnip snippets engine
require("luasnip.loaders.from_vscode").lazy_load()

-- If you have custom snippets at "./path/to/my/snippets"
-- NOTE: above directory has to have a package.json file
-- require("luasnip.loaders.from_vscode").lazy_load({
--   paths = { "./path/to/my/snippets" }
-- })

-- nice symbols ⍟ ⎈ ⎊  ⍰ ⛭ 🌣 ✂  ✄  ✮ ✄  ✂  ✀

-- Changing diagnostic icons
local function Change_Diagnostic_Sign(opts)
  vim.fn.sign_define(opts.name, {
    text = opts.text,
    texthl = opts.name,
    numhl = "",
  })
end

Change_Diagnostic_Sign({ name = "DiagnosticSignError", text = "🕱 " })
Change_Diagnostic_Sign({ name = "DiagnosticSignHint", text = "💡" })
Change_Diagnostic_Sign({ name = "DiagnosticSignInfo", text = "ⓘ " })
Change_Diagnostic_Sign({ name = "DiagnosticSignWarn", text = "⚠" })
