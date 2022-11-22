--=============================================================================
-- Neovim Nightly Edtion (version 0.9)
-- Configuration for completion plugin nvim-cmp
--=============================================================================

-- luasnip setup
local luasnip = require "luasnip"

-- nvim-cmp setup
local cmp = require "cmp"
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm {
      behaviour = cmp.ConfirmBehavior.Replace,
      select = false
    },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
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
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer", keyword_length = 4 },
  }),
}

-- Make it so that a menu pops up as we're typing, but only if there is
-- something before the cursor and nothing after.
-- https://github.com/hrsh7th/nvim-cmp/issues/519
-- vim.api.nvim_create_autocmd(
--   { "TextChangedI", "TextChangedP" },
--   {
--     callback = function()
--       local line = vim.api.nvim_get_current_line()
--       local cursor = vim.api.nvim_win_get_cursor(0)[2]

--       local current = string.sub(line, cursor, cursor + 1)
--       if current == "." or current == "," or current == " " then
--         cmp.close()
--       end

--       local before_line = string.sub(line, 1, cursor + 1)
--       local after_line = string.sub(line, cursor + 1, -1)
--       if not string.match(before_line, "^%s+$") then
--         if after_line == "" or string.match(before_line, " $")
--             or string.match(before_line, "%.$") then
--           cmp.complete()
--         end
--       end
--     end,
--     pattern = "*",
--   }
-- )
