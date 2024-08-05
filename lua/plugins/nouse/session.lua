-- ~/.config/nvim/lua/plugins.lua
return {
  -- 其他插件配置
  {
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup {
        log_level = "info",
        auto_save_enabled = true,
        auto_restore_enabled = true,
        post_restore_cmds = { "NvimTreeOpen" }, -- 恢复会话后自动执行的命令
        session_directory = vim.fn.stdpath("data") .. "/sessions", -- 自定义会话目录
      }
    end,
  },
}
