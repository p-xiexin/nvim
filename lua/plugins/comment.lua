-- ~/.config/nvim/lua/plugins.lua
return {
	-- 其他插件配置
  
	-- 添加 nvim_comment 插件
	{
	  "terrortylor/nvim-comment",
	  config = function()
		local status_ok, comment = pcall(require, "nvim_comment")
		if not status_ok then
		  vim.notify("comment not found!")
		  return
		end
  
		comment.setup {
		  -- Linters prefer comment and line to have a space in between markers
		  marker_padding = true,
		  -- Should comment out empty or whitespace only lines
		  comment_empty = true,
		  -- Should key mappings be created
		  create_mappings = true,
		  -- Normal mode mapping left hand side
		  line_mapping = "gcc",
		  -- Visual/Operator mapping left hand side
		  operator_mapping = "gc",
		  -- Hook function to call before commenting takes place
		  hook = function()
			local filetype = vim.api.nvim_buf_get_option(0, "filetype")
			if filetype == "cpp" then
			  vim.api.nvim_buf_set_option(0, "commentstring", "// %s")
			elseif filetype == "c" then
			  vim.api.nvim_buf_set_option(0, "commentstring", "/* %s */")
			elseif filetype == "go" then
			  vim.api.nvim_buf_set_option(0, "commentstring", "// %s")
			elseif filetype == "shell" then
			  vim.api.nvim_buf_set_option(0, "commentstring", "# %s")
			elseif filetype == "lua" then
			  vim.api.nvim_buf_set_option(0, "commentstring", "-- %s")
			end
		  end
		}
	  end,
	},
  }
