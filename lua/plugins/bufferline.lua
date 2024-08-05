return {
	"akinsho/bufferline.nvim",
	event = "VeryLazy",
	opts = {
		options = {
			mode = "buffer",
			numbers = "ordinal",
			offsets = {{filetype = "NvimTree", text = "File Explorer", text_align = "center"}},
		},
		highlights = {
			buffer_selected = { italic = false, bold = false },
		},
	},
	config = function(_, opts)
		require("bufferline").setup(opts)
		-- Fix bufferline when restoring a session
		vim.api.nvim_create_autocmd("BufAdd", {
			callback = function()
				vim.schedule(function()
					pcall(nvim_bufferline)
				end)
			end,
		})
	end,
}
