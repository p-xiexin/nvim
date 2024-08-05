-- ~/.config/nvim/lua/plugins.lua
return {
    {
      "nvim-treesitter/nvim-treesitter",
      event = "BufReadPost", 
      run = ":TSUpdate",
      config = function()
        require('nvim-treesitter.configs').setup({                                               
            -- 支持的语言
            ensure_installed = {"lua","c", "cpp", "python", "bash", "vim", "html"},
            -- 启用代码高亮
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false
            },
            --启用增量选择
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<CR>',
                    node_incremental = '<CR>',
                    node_decremental = '<BS>',
                    scope_incremental = '<TAB>'
                }
            },
            -- 启用基于 Treesitter 的代码格式化(=)
            indent = {
                enable = true
            },
        })
      end,
    },
}