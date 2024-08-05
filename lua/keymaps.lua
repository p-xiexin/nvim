-- 定义通用的按键映射选项
local opts = {
	noremap = true,      -- 不递归映射，防止按键重复映射
	silent = true,       -- 不显示命令行消息
}

-----------------
-- 普通模式 --
-----------------

-- 通过按住 Ctrl 键进行更好的窗口导航
-- <C-h> 向左移动窗口
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
-- <C-j> 向下移动窗口
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
-- <C-k> 向上移动窗口
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
-- <C-l> 向右移动窗口
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

-- 使用箭头键调整窗口大小
-- <C-Up> 减少窗口高度（向上缩小）
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', opts)
-- <C-Down> 增加窗口高度（向下放大）
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', opts)
-- <C-Left> 减少窗口宽度（向左缩小）
vim.keymap.set('n', '<C-Left>', ':vertical resize +2<CR>', opts)
-- <C-Right> 增加窗口宽度（向右放大）
vim.keymap.set('n', '<C-Right>', ':vertical resize -2<CR>', opts)

-----------------
-- 可视模式 --
-----------------

-- 在可视模式下保持选择区域一致性
-- < 应该缩进，保持选择区域不变
vim.keymap.set('v', '<', '<gv', opts)
-- > 应该取消缩进，保持选择区域不变
vim.keymap.set('v', '>', '>gv', opts)


-- 自动补全
-- vim.api.nvim_set_keymap('i', '(', '()<ESC>i', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('i', ')', '<c-r>=ClosePair(\')\')<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('i', '{', '{}<ESC>i', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('i', '{<CR>', '{<CR>}<ESC>O', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('i', '[', '[]<ESC>i', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('i', ']', '<c-r>=ClosePair(\']\')<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('i', '"', '""<ESC>i', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('i', "'", "''<ESC>i", { noremap = true, silent = true })

-- nvimtree
vim.api.nvim_set_keymap('n', "tt", ':NvimTreeToggle<CR>', { noremap = true, silent = true })

--telescope
vim.api.nvim_set_keymap('n', '<Space>f', ':Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space>b', ':Telescope file_browser<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space>r', ':Telescope oldfiles<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space>p', ':Telescope project<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space>g', ':Telescope live_grep_args<CR>', { noremap = true, silent = true })

-- bufferline
vim.api.nvim_set_keymap("n", "<leader>1", ":BufferLineGoToBuffer 1<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>2", ":BufferLineGoToBuffer 2<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>3", ":BufferLineGoToBuffer 3<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>4", ":BufferLineGoToBuffer 4<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>5", ":BufferLineGoToBuffer 5<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>6", ":BufferLineGoToBuffer 6<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>7", ":BufferLineGoToBuffer 7<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>8", ":BufferLineGoToBuffer 8<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>9", ":BufferLineGoToBuffer 9<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>bg", ":BufferLinePick", {noremap = true, silent = true})

vim.api.nvim_set_keymap("n", "<A-Left>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-Right>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>bc', ':bd<CR>', { noremap = true, silent = true })
