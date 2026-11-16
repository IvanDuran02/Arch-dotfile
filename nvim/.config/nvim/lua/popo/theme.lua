return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				color_overrides = {
					mocha = {
						base = "#13131f",
					},
				},
				transparent_background = false,
				show_end_of_buffer = false,
				term_colors = true,
				integrations = {
					cmp = true,
					gitsigns = true,
					harpoon = true,
					treesitter = true,
					which_key = true,
					snacks = true,
					trouble = true,
					mini = { enabled = true },
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				theme = "catppuccin",
				section_separators = "",
				component_separators = "",
			},
		},
	},
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("dashboard").setup({
				theme = "hyper",
				config = {
					week_header = { enable = true },
					shortcut = {
						{ desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
						{
							icon = " ",
							icon_hl = "@variable",
							desc = "Files",
							group = "Label",
							action = "Telescope find_files",
							key = "f",
						},
						{
							desc = " Diagnostics",
							group = "Number",
							action = "Telescope diagnostics",
							key = "d",
						},
					},
					packages = { enable = true },
					footer = { "", "🚀 Let's build something great." },
				},
			})
		end,
	},
}
