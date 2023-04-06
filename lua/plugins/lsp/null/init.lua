local M = {}

local null = require("null-ls")
local null_utils = require("null-ls.utils")
local builtins = null.builtins

local with_diagnostics_code = function(builtin)
  return builtin.with({
    diagnostics_format = '#{m} [#{c}]',
  })
end

local with_root_file = function(builtin, file)
  return builtin.with({
    condition = function(utils)
      return utils.root_has_file(file)
    end,
  })
end

local sources = {
  -- formatting
  builtins.formatting.prettierd,
  builtins.formatting.shfmt,
  builtins.formatting.fixjson,
  builtins.formatting.black.with({ extra_args = { "--fast" } }),
  builtins.formatting.isort,
  with_root_file(builtins.formatting.stylua, "stylua.toml"),

  -- diagnostics
  builtins.diagnostics.write_good,
  builtins.diagnostics.markdownlint,
  builtins.diagnostics.eslint_d,
  builtins.diagnostics.flake8,
  builtins.diagnostics.tsc,
  with_root_file(builtins.diagnostics.selene, "selene.toml"),
  with_diagnostics_code(builtins.diagnostics.shellcheck),

  -- code actions
  builtins.code_actions.gitsigns,
  builtins.code_actions.gitrebase,

  -- hover
  builtins.hover.dictionary,
}

function M.setup(opts)
  null.setup({
    -- debug = true,
    debounce = 150,
    save_after_format = false,
    sources = sources,
    on_attach = opts.on_attach,
    root_dir = null_utils.root_pattern('.git'),
  })
end

return M
