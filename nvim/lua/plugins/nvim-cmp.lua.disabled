return {
  {
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    -- Supertab
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
            cmp.select_next_item()
          elseif vim.snippet.active({ direction = 1 }) then
            vim.schedule(function()
              vim.snippet.jump(1)
            end)
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.snippet.active({ direction = -1 }) then
            vim.schedule(function()
              vim.snippet.jump(-1)
            end)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
      -- Add custom formatting to show source names in the completion menu
      opts.formatting = {
        fields = { "abbr", "menu", "kind" }, -- Specify fields to display
        format = function(entry, vim_item)
          -- Define source names for display
          local menu_icon = {
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            luasnip = "[Snippet]",
            path = "[Path]",
          }
          vim_item.menu = menu_icon[entry.source.name] or entry.source.name
          return vim_item
        end,
      }
      -- Set window borders for the completion and documentation popups
      opts.window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      }
    end,
  },
}
