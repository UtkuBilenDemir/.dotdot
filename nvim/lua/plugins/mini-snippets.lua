return {
  "nvim-mini/mini.snippets",
  version = false,
  config = function()
    local ms = require("mini.snippets")
    ms.setup({
      snippets = {
        -- Load lua/snips/<filetype>.json for the current buffer.
        -- Use vim filetype, NOT context.lang: treesitter reports "latex" for tex
        -- buffers, but our files are named by vim filetype (tex.json, markdown.json).
        function(context)
          local ft = vim.bo[context.buf_id].filetype
          local path = vim.fn.stdpath("config") .. "/lua/snips/" .. ft .. ".json"
          if vim.fn.filereadable(path) == 0 then return {} end
          -- cache = false so edits via nvim-scissors are picked up immediately.
          return ms.gen_loader.from_file(path, { cache = false })(context)
        end,
      },
    })

    -- Tab: jump to next tabstop while in a snippet session, else fall through.
    -- Reload snippets automatically when nvim-scissors saves a JSON file.
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = vim.fn.stdpath("config") .. "/lua/snips/*.json",
      callback = function()
        require("blink.cmp").reload("snippets")
      end,
      desc = "Reload snippets after nvim-scissors edit",
    })

    vim.keymap.set({ "i", "s" }, "<Tab>", function()
      if MiniSnippets.session.get() then
        MiniSnippets.session.jump("next")
      else
        vim.api.nvim_feedkeys(
          vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false
        )
      end
    end, { desc = "mini.snippets next tabstop" })

    vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
      if MiniSnippets.session.get() then
        MiniSnippets.session.jump("prev")
      else
        vim.api.nvim_feedkeys(
          vim.api.nvim_replace_termcodes("<S-Tab>", true, false, true), "n", false
        )
      end
    end, { desc = "mini.snippets prev tabstop" })

  end,
}
