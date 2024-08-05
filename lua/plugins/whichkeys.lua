return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim", -- 确保 plenary.nvim 已经加载
			"nvim-lua/popup.nvim", -- 可选的弹出窗口插件
			"echasnovski/mini.icons",
		},
		config = function()
			local which_key = require("which-key")

			local setup = {
				plugins = {
					marks = false,
					registers = true,
					spelling = { enabled = false, suggestions = 20 },
					presets = {
						operators = false,
						motions = false,
						text_objects = false,
						windows = true,
						nav = true,
						z = false,
						g = false,
					},
				},
				icons = {
					breadcrumb = "»",
					separator = "➜",
					group = "+",
					ellipsis = "…",
					keys = {
						Esc = "<esc>",
						BS = "<bs>",
						CR = "<cr>",
						Space = "<space>",
						Tab = "<tab>",
					},
					mappings = false,
				},
				keys = {
					scroll_down = "<c-d>",
					scroll_up = "<c-u>",
				},
				layout = {
					height = { min = 4, max = 25 },
					width = { min = 20, max = 50 },
					spacing = 3,
					align = "left",
				},
				show_help = true,
			}

			which_key.setup(setup)
			which_key.add({
				{ "gd",        desc = "Goto Definition",      mode = "n" },
				{ "gi",        desc = "Goto Implementation",  mode = "n" },
				{ "gr",        desc = "Find Reference",       mode = "n" },
				{ "gD",        desc = "Goto Declaration",     mode = "n" },
				{ "gt",        desc = "Goto Type Definition", mode = "n" },
				{ "<leader>f", desc = "Format",               mode = "n" },
			})
		end,
	},
}
