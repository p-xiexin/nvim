-- ~/.config/nvim/lua/plugins.lua
local handler = require("lsp.handler")

return {
  -- LSP 配置
  {
    "neovim/nvim-lspconfig", -- Enable LSP
    config = function()
      local lspconfig = require("lspconfig")
      handler.setup{}
      -- 这里可以添加你希望配置的 LSP 服务器
      lspconfig.pyright.setup{}
      lspconfig.lua_ls.setup{}
      lspconfig.clangd.setup{}
    end,
  },
  {
    "williamboman/mason.nvim", -- 简单易用的语言服务器安装器
    config = function()
      require("mason").setup{}
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      local mason_lspconfig = require("mason-lspconfig")

      mason_lspconfig.setup {
        ensure_installed = { "lua_ls", "clangd" } -- 确保安装的语言服务器
      }

      -- 定义 LSP 快捷键和其他配置
      local on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }

        -- 设置 LSP 快捷键
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)           -- 跳转到定义
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)      -- 跳转到实现
        --vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)          -- 查找引用
        vim.keymap.set('n', 'gr', handler.go_to_reference, opts)                  -- 查找引用
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)         -- 跳转到声明
        vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)     -- 跳转到类型定义
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)      -- 重命名符号
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts) -- 显示代码操作
        vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end, opts) -- 格式化代码
      end

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if status_ok then
        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
      end

      mason_lspconfig.setup_handlers {
        function(server_name)
          require("lspconfig")[server_name].setup {
            on_attach = on_attach,
            capabilities = capabilities,
            flags = {
              debounce_text_changes = 150,
            }
          }
        end,
      }
    end,
  },
  {
    "kosayoda/nvim-lightbulb", -- 代码操作提示
    config = function()
      require("nvim-lightbulb").setup {}
      -- 自动命令，在光标悬停时更新 lightbulb
      vim.api.nvim_create_autocmd("CursorHold", {
        callback = function()
          require('nvim-lightbulb').update_lightbulb()
        end,
      })
    end,
  },
  {
    "ray-x/lsp_signature.nvim", -- 函数签名提示
    config = function()
      require("lsp_signature").setup {}
    end,
  },
}