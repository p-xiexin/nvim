local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	--主题颜色
	require("plugins.colorscheme"),
	require("plugins.transparent"),
	--搜索文件
	require("plugins.telescope"),
	--状态栏
	require("plugins.statusline"),
	--文件标签
	require("plugins.bufferline"),
	--nvim-tree
	require("plugins.nvimtree"),
	--通知消息
	require("plugins.notify"),
	--按键提示
	require("plugins.whichkeys"),
	--欢迎界面
	require("plugins.alpha"),
	--vim terminal in the floating/popup window
	require("plugins.toggleterm"),
	--auto-session
	require("plugins.session_manager"),
	--require("plugins.session"),
	--Autocomplete
	require("plugins.cmp"),
	-- require("plugins.treesitter"),
	--lsp
	require("lsp.lspconfig"),
	require("lsp.highlight"),
	--require("plugins.snippets"),
	--debugger
	--require("plugins.debugger"),
	--多行注释,单行注释gcc，多行注释vgc
	require("plugins.comment"),
	require("plugins.auto_pairs"),
	--文件大纲
	require("plugins.aerial"),
	--Change Surround examples Press cs"'
	--require("plugins.surround"),
	--markdown
	--require("plugins.markdown"),
	--Git
	--require("plugins.git"),
	--缩进线
	require("plugins.indent"),
	--search
	--require("plugins.search"),
	--UNdotree
	--require("plugins.undo"),
	--wildmenu
	--require("plugins.wilder"),
	--AI code
	--require("plugins.copilot"),
	--做题
	require("plugins.leetcode"),
})

-- require("compile_run")
