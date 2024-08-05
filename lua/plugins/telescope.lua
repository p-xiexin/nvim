return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = {
			"nvim-telescope/telescope-live-grep-args.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			"nvim-telescope/telescope-project.nvim", -- 管理项目的插件
		},
		keys = {},
		config = function()
			if vim.fn.empty(vim.fn.glob('/usr/bin/rg')) > 0 then
				print("ripgrep (rg) is not installed. Please install it for better functionality.")
			end
			require("telescope").load_extension("file_browser")
			require("telescope").load_extension("project")
			require("telescope").load_extension('live_grep_args')
			-- require("telescope").load_extension('fzf')
		end,
	},
}
