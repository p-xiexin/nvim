return {  
    -- 文档高亮插件
    {
      "RRethy/vim-illuminate",
      config = function()
        require("illuminate").configure({
          providers = {
            "lsp",
            "treesitter",
            "regex",
          },
          delay = 200,  -- 延迟时间，单位为毫秒
          filetypes_denylist = {
            "dirvish",
            "fugitive",
          },
          filetypes_allowlist = {},
          modes_denylist = {},
          modes_allowlist = {},
          providers_regex_syntax_denylist = {},
          providers_regex_syntax_allowlist = {},
          under_cursor = true,
        })
  
        -- 设置快捷键切换高亮的符号
        vim.api.nvim_set_keymap('n', '<leader>n', '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>', { noremap=true, silent=true })
        vim.api.nvim_set_keymap('n', '<leader>p', '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>', { noremap=true, silent=true })
      end,
    },
  }