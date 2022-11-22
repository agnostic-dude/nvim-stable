--=========================================================================
-- Neovim Stable (version 0.8)
-- Lua configuration: plugins
--=========================================================================
local function ensure_packer_installed()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({
			"git",
			"clone",
			"--depth",
			"1",
			"https://github.com/wbthomason/packer.nvim",
			install_path,
		})
		vim.cmd([[ packadd packer.nvim ]])
		return true
	end
	return false
end

local packer = require("packer")
local packer_bootstrap = ensure_packer_installed()

return packer.startup(function(use)
	-- Manage package manager
	use("wbthomason/packer.nvim")

	-- Persistant, toggled floating terminals
	use("akinsho/toggleterm.nvim")

	--> Utilities for coding
	use("jiangmiao/auto-pairs") --> autocomplete & link parenthesis
	use("tpope/vim-commentary") --> gc/gcc to comment/uncomment
	use("lukas-reineke/indent-blankline.nvim") --> show indentation levels
	use("RRethy/vim-illuminate") --> smart highlighting of words under cursor

	--> Statusline
	use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons", opt = false } })

	--> Git support
	use({ "lewis6991/gitsigns.nvim", requires = "nvim-lua/plenary.nvim" })

	--> Treesitter
	use({ "nvim-treesitter/nvim-treesitter", run = "<Cmd>TSUpdate" })
	use("nvim-treesitter/nvim-treesitter-textobjects")
	use("p00f/nvim-ts-rainbow") --> color matched parenthesis with treesitter
	use({
		"folke/trouble.nvim",
		requires = {
			"kyazdani42/nvim-web-devicons",
			"folke/lsp-colors.nvim", -- create highlight groups missing from theme
		},
	})

	--> Cycle through all colorschemes
	use("vim-scripts/CycleColor") --> cycle through colorschemes in rtp

	--> Colorschemes
	use("joshdick/onedark.vim") --> theme inspired by Atom
	use("folke/tokyonight.nvim") --> TokyoNight colorscheme for VSCode
	use("tomasiser/vim-code-dark") --> inspired by Dark+ scheme of VSCode
	use("NLKNguyen/papercolor-theme") --> inspired by Google's Material Design
	use("liuchengxu/space-vim-theme") --> dark & light with GUI support
	use("sainnhe/gruvbox-material") --> modified gruvbox with softer contrast
	use("sainnhe/everforest") --> green based, designed to be warm & soft
	use("sainnhe/sonokai") --> vivid theme based on Monokai Pro
	use("sainnhe/edge") --> inspired by Atom One & Material

	--> Emoji in vim
	use("junegunn/vim-emoji")

	--> LSP related
	use("neovim/nvim-lspconfig") --> configs for builtin LSP client
	use("hrsh7th/nvim-cmp") --> completion engine in lua
	use("hrsh7th/cmp-nvim-lsp") --> nvim-cmp sources
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use({ "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" })
	use("onsails/lspkind.nvim")

	--> Snippets
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")
	use("rafamadriz/friendly-snippets")

	--> Telescope
	use({ "nvim-telescope/telescope.nvim", tag = "0.1.0", requires = "nvim-lua/plenary.nvim" })
	--> FZY type sorted for telescope
	use("nvim-telescope/telescope-fzy-native.nvim")
	use("romgrk/fzy-lua-native")

	-- Debug Adapter Protocol plugins
	use("mfussenegger/nvim-dap")
	use("rcarriga/nvim-dap-ui") -- out-of-the-box TUI
	use("theHamsta/nvim-dap-virtual-text") -- vars in virtual text
	use("Pocco81/DAPInstall.nvim")
	use("nvim-telescope/telescope-dap.nvim") -- Telescope support
	use("mfussenegger/nvim-dap-python")
	use({ "jbyuki/one-small-step-for-vimkind", module = "osv" }) -- Lua

	-- Running vimspector because dap-nvim is fucked!
	use("puremourning/vimspector")

	-- Refactoring library based-off of book by Martin Fowler
	use({
		"ThePrimeagen/refactoring.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
	})

	--> Splash screen
	use({
		"goolord/alpha-nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
		-- config = function()
		--     local startify = require("alpha.themes.startify")
		--     require("alpha").setup(startify.opts)
		--     startify.section.bottom_buttons.val = {
		--         startify.button("v", "Neovim Config",
		--             "<cmd>e ~/.config/nvim/init.lua<cr>"),
		--         startify.button("q", "Quit Neovim", "<cmd>q <cr>"),
		--     }
		-- end,
	})

	use({
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({})
		end,
	})
	-- At end of all plugins to automatically setup configuration after
	-- clonning packer.nvim
	if packer_bootstrap then
		print("Need to restart neovim after installation")
		packer.sync()
	end
end)
