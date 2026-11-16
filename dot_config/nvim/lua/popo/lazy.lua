local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local lazy_plugins = {
	require("popo.theme"),
	require("popo.formatting"),
	require("popo.lsp"),

	"folke/which-key.nvim",
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	"tpope/vim-fugitive",
	"mbbill/undotree",
	{
		"NvChad/nvim-colorizer.lua",
		opts = {
			user_default_options = {
				names = false,
				RGB = true,
				RRGGBB = true,
				tailwind = true,
			},
		},
	},
	{
		"theprimeagen/harpoon",
		config = function()
			require("harpoon").setup({
				global_settings = {
					save_on_toggle = false,
					save_on_change = true,
				},
			})
		end,
	},
	{ "folke/neoconf.nvim", cmd = "Neoconf" },
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			bigfile = { enabled = true },
			indent = { enabled = true },
			input = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scope = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
		},
	},
	{
		"numToStr/Comment.nvim",
		opts = {
			toggler = {
				line = "<C-_>",
				block = "<C-b>",
			},
			opleader = {
				line = "gc",
				block = "gb",
			},
		},
		lazy = false,
	},
}

require("lazy").setup(lazy_plugins)
