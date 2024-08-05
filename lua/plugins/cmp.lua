return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- LSP 相关补全源
      "hrsh7th/cmp-buffer", -- 缓冲区内容补全源
      "hrsh7th/cmp-path", -- 文件路径补全源
      "hrsh7th/cmp-cmdline", -- 命令行补全源:
      "L3MON4D3/LuaSnip", -- LuaSnip 插件
      "hrsh7th/cmp-calc", -- 计算器补全源
      "hrsh7th/cmp-emoji", -- 表情符号补全源
      "hrsh7th/cmp-nvim-lua", -- Lua API 补全源
      "saadparwaiz1/cmp_luasnip", -- LuaSnip 补全源
      "ray-x/cmp-treesitter", -- Treesitter 补全源
      "petertriho/cmp-git", -- Git 补全源
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- 检查光标前是否是空格，以决定是否可以插入补全
      local check_backspace = function()
        local col = vim.fn.col "." - 1
        return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
      end

      -- 判断当前是否在一个 LuaSnip 片段中，并能否跳转
      local function jumpable(dir)
        local luasnip_ok, luasnip = pcall(require, "luasnip")
        if not luasnip_ok then
          return false
        end

        local win_get_cursor = vim.api.nvim_win_get_cursor
        local get_current_buf = vim.api.nvim_get_current_buf

        -- 检查光标是否在片段内
        local function inside_snippet()
          if not luasnip.session.current_nodes then
            return false
          end

          local node = luasnip.session.current_nodes[get_current_buf()]
          if not node then
            return false
          end

          local snip_begin_pos, snip_end_pos = node.parent.snippet.mark:pos_begin_end()
          local pos = win_get_cursor(0)
          pos[1] = pos[1] - 1
          return pos[1] >= snip_begin_pos[1] and pos[1] <= snip_end_pos[1]
        end

        -- 寻找光标所在的 LuaSnip 片段节点
        local function seek_luasnip_cursor_node()
          if not luasnip.session.current_nodes then
            return false
          end

          local pos = win_get_cursor(0)
          pos[1] = pos[1] - 1
          local node = luasnip.session.current_nodes[get_current_buf()]
          if not node then
            return false
          end

          local snippet = node.parent.snippet
          local exit_node = snippet.insert_nodes[0]

          if exit_node then
            local exit_pos_end = exit_node.mark:pos_end()
            if (pos[1] > exit_pos_end[1]) or (pos[1] == exit_pos_end[1] and pos[2] > exit_pos_end[2]) then
              snippet:remove_from_jumplist()
              luasnip.session.current_nodes[get_current_buf()] = nil
              return false
            end
          end
	        node = snippet.inner_first:jump_into(1, true)
          while node ~= nil and node.next ~= nil and node ~= snippet do
            local n_next = node.next
            local next_pos = n_next and n_next.mark:pos_begin()
            local candidate = n_next ~= snippet and next_pos and (pos[1] < next_pos[1])
                or (pos[1] == next_pos[1] and pos[2] < next_pos[2])

            -- 若无候选节点，退出
            if n_next == nil or n_next == snippet.next then
              snippet:remove_from_jumplist()
              luasnip.session.current_nodes[get_current_buf()] = nil
              return false
            end

            if candidate then
              luasnip.session.current_nodes[get_current_buf()] = node
              return true
            end

            local ok
            ok, node = pcall(node.jump_from, node, 1, true)
            if not ok then
              snippet:remove_from_jumplist()
              luasnip.session.current_nodes[get_current_buf()] = nil
              return false
            end
          end

          -- 无候选节点，但有退出节点，跳转到退出节点
          if exit_node then
            luasnip.session.current_nodes[get_current_buf()] = snippet
            return true
          end

          -- 无退出节点，退出片段
          snippet:remove_from_jumplist()
          luasnip.session.current_nodes[get_current_buf()] = nil
          return false
        end

        if dir == -1 then
          return inside_snippet() and luasnip.jumpable(-1)
        else
          return inside_snippet() and seek_luasnip_cursor_node() and luasnip.jumpable()
        end
      end

      -- 检查 emmet_ls 是否在缓冲区中启用
      local is_emmet_active = function()
        local clients = vim.lsp.buf_get_clients()
        for _, client in pairs(clients) do
          if client.name == "emmet_ls" then
            return true
          end
        end
        return false
      end

      -- 配置 nvim-cmp
      cmp_config = {
        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Replace, -- 确认行为设置为替换
          select = false, -- 禁用自动选择
        },
        completion = {
          keyword_length = 1, -- 补全的最小关键字长度
        },
        experimental = {
          ghost_text = false, -- 关闭幽灵文本
          native_menu = false, -- 禁用本地菜单
        },
        formatting = {
          fields = { "kind", "abbr", "menu" }, -- 补全项的字段
          max_width = 0, -- 最大宽度设置
          kind_icons = {
            Class = " ",
            Color = " ",
            Constant = "ﲀ ",
            Constructor = " ",
            Enum = "練",
            EnumMember = " ",
            Event = " ",
            Field = " ",
            File = "",
            Folder = " ",
            Function = " ",
            Interface = "ﰮ ",
            Keyword = " ",
            Method = " ",
            Module = " ",
            Operator = "",
            Property = " ",
            Reference = " ",
            Snippet = " ",
            Struct = " ",
            Text = " ",
            TypeParameter = " ",
            Unit = "塞",
            Value = " ",
            Variable = " ",
          },
          source_names = {
            nvim_lsp = "(LSP)",
            treesitter = "(TS)",
            emoji = "(Emoji)",
            path = "(Path)",
            calc = "(Calc)",
            cmp_tabnine = "(Tabnine)",
            vsnip = "(Snippet)",
            luasnip = "(Snippet)",
            buffer = "(Buffer)",
            spell = "(Spell)",
          },
          duplicates = {
            buffer = 1,
            path = 1,
            nvim_lsp = 0,
            luasnip = 1,
          },
          duplicates_default = 0,
          format = function(entry, vim_item)
            local max_width = cmp_config.formatting.max_width
            if max_width ~= 0 and #vim_item.abbr > max_width then
              vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. "…"
            end
            vim_item.kind = cmp_config.formatting.kind_icons[vim_item.kind]
            vim_item.menu = cmp_config.formatting.source_names[entry.source.name]
            vim_item.dup = cmp_config.formatting.duplicates[entry.source.name]
                or cmp_config.formatting.duplicates_default
            return vim_item
          end,
        },
	      snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body) -- 扩展 LuaSnip 片段
          end,
        },
        window = {
          completion = cmp.config.window.bordered(), -- 边框配置
          documentation = cmp.config.window.bordered(), -- 边框配置
        },
        sources = {
          { name = "nvim_lsp" }, -- LSP 来源
          { name = "path" }, -- 路径来源
          { name = "luasnip" }, -- LuaSnip 来源
          { name = "cmp_tabnine" }, -- Tabnine 来源
          { name = "nvim_lua" }, -- Neovim Lua 来源
          { name = "buffer" }, -- 缓冲区来源
          { name = "spell" }, -- 拼写检查来源
          { name = "calc" }, -- 计算器来源
          { name = "emoji" }, -- 表情符号来源
          { name = "treesitter" }, -- Treesitter 来源
        },
        mapping = cmp.mapping.preset.insert {
          ["<C-k>"] = cmp.mapping.select_prev_item(), -- 选择上一个补全项
          ["<C-j>"] = cmp.mapping.select_next_item(), -- 选择下一个补全项
          ["<C-d>"] = cmp.mapping.scroll_docs(-4), -- 向上滚动文档
          ["<C-f>"] = cmp.mapping.scroll_docs(4), -- 向下滚动文档
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item() -- 选择下一个补全项
            elseif luasnip.expandable() then
              luasnip.expand() -- 展开 LuaSnip 片段
            elseif jumpable(1) then
              luasnip.jump(1) -- 向前跳转 LuaSnip 节点
            elseif check_backspace() then
              fallback() -- 触发默认回退行为
            elseif is_emmet_active() then
              return vim.fn["cmp#complete"]() -- 触发 Emmet 补全
            else
              fallback() -- 触发默认回退行为
            end
          end, {
            "i",
            "s",
          }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item() -- 选择上一个补全项
            elseif jumpable(-1) then
              luasnip.jump(-1) -- 向后跳转 LuaSnip 节点
            else
              fallback() -- 触发默认回退行为
            end
          end, {
            "i",
            "s",
          }),

          ["<C-p>"] = cmp.mapping.complete(), -- 触发补全
          ["<C-e>"] = cmp.mapping.abort(), -- 取消补全
          ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() and cmp.confirm(cmp_config.confirm_opts) then
              if jumpable(1) then
                luasnip.jump(1) -- 向前跳转 LuaSnip 节点
              end
              return
            end

            if jumpable(1) then
              if not luasnip.jump(1) then
                fallback() -- 触发默认回退行为
              end
            else
              fallback() -- 触发默认回退行为
            end
          end),
        },
      }

      -- 为 `/` 使用缓冲区来源
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- 为 `?` 使用缓冲区来源
      cmp.setup.cmdline('?', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- 为 `:` 使用命令行和路径来源
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'cmdline' }
        }, {
          { name = 'path' }
        })
      })

      -- 为特定文件类型禁用自动补全
      vim.cmd("autocmd FileType guihua lua require('cmp').setup.buffer { enabled = false }")
      vim.cmd("autocmd FileType guihua_rust lua require('cmp').setup.buffer { enabled = false }")

      cmp.setup(cmp_config) -- 应用配置
    end,
  },
}
