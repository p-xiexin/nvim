return {
    {
      "xiyaowong/nvim-transparent",
      config = function()
        require("transparent").setup({
          --enable = true, -- 启用透明背景
          extra_groups = { -- 额外需要透明的组
            "NormalFloat",    -- 浮动窗口
            "NvimTreeNormal", -- NvimTree
            "BufferLineBackground",
            "LualineNormal",  -- Lualine 背景
          },
          exclude_groups = {}, -- 排除的组
        })
        require('transparent').clear_prefix('BufferLine')
        require('transparent').clear_prefix('NvimTree')
        require('transparent').clear_prefix('lualine')
      end,
    },
}