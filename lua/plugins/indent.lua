-- ~/.config/nvim/lua/plugins.lua
return {
	-- 其他插件配置
	{
	  "lukas-reineke/indent-blankline.nvim",
	  main = "ibl",
	  config = function()
		require("ibl").setup {
		  indent = { char = "|" },
		  exclude = {
			buftypes = { "terminal" },
			filetypes = { "help", "dashboard", "packer", "NvimTree" }
		  },
		  scope = {
			show_start = true,
			show_end = true,
		  },
		}
	  end,
	},
  }