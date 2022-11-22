--=========================================================================
-- Neovim Stable (version 0.8)
-- nvim-dap: Debug Adaptor Protocol implementation for neovim
-- initialization
--=========================================================================
local dap = prequire("dap")

local dap_virtual_text = prequire("nvim-dap-virtual-text")
if dap_virtual_text then
    dap_virtual_text.setup()
end

local dap_install = prequire("dap-install")
if dap_install then
    dap_install.setup()
end


-- Python
dap.adapters.python = {
    type = "executable",
    command = os.getenv("HOME") .. "/.virtualenvs/debugpy/bin/python",
    args = { "-m", "debugpy.adapter"
    }
}

dap.configurations.python = {
    {
        -- These 3 options are required by nvim-dap
        type = "python",
        request = "launch",
        name = "Launch File",

        -- Following options are for debugpy
        program = "${file}",
        pythonPath = function()
            -- debugpy supports launching an application with a different
            -- interpreter than the one used to launch to debugpy itself.
            -- Code below looks for `venv` or `.venv` in current directory and
            -- uses python interpreter within. You could adapt this, for example
            -- to use the `VIRTUAL_ENV` environment variable.
            local cwd = vim.fn.getcwd()
            if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
                return cwd .. '/venv/bin/python'
            elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                return cwd .. '/.venv/bin/python'
            else
                return '/usr/bin/python'
            end
        end,
    }
}
