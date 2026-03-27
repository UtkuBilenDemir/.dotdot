-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = LazyVim.safe_keymap_set

-- ============================================================================
-- NAVIGATION — LINK FOLLOWING
-- ============================================================================

-- gf   : open link under cursor in current window (built-in, works for both
--         regular paths and Obsidian [[wikilinks]] via obsidian.nvim)
-- gV/gH: same but in a vertical or horizontal split. Detects [[wikilinks]]
--         and delegates to ObsidianFollowLink for correct vault resolution;
--         falls back to <C-w>vf / <C-w>f for regular file paths.
local function follow_link(split)
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  if line:sub(1, col + 2):match("%[%[") or line:find("%[%[.*%]%]") then
    vim.cmd("ObsidianFollowLink " .. split)
  else
    vim.cmd("wincmd " .. (split == "vsplit" and "v" or "") .. "f")
  end
end
map("n", "gV", function() follow_link("vsplit") end, { desc = "Follow link in vsplit" })
map("n", "gH", function() follow_link("hsplit") end, { desc = "Follow link in hsplit" })

-- ============================================================================
-- OBSIDIAN
-- ============================================================================

-- All Obsidian keymaps live under <leader>o.
-- URI-based commands use `open -g` to keep Obsidian in the background.
-- Commands that modify the active note trigger `checktime` after a delay
-- so Neovim reloads the buffer once Templater has finished writing.

-- Navigation
map("n", "<leader>oo", "<cmd>ObsidianQuickSwitch<cr>", { desc = "Obsidian: quick switch" })
map("n", "<leader>op", function()
  -- Open the current buffer's note in the Obsidian app (brings Obsidian to focus)
  local vault = "/Users/ubd/Library/Mobile Documents/iCloud~md~obsidian/Documents/rhizome"
  local filepath = vim.fn.expand("%:p"):gsub(vim.pesc(vault .. "/"), "")
  vim.fn.system("open 'obsidian://adv-uri?vault=rhizome&filepath=" .. filepath .. "'")
end, { desc = "Obsidian: open in Obsidian" })

-- New note
-- Triggers zk-prefixer via Advanced URI (creates timestamped note in
-- 02_zettelkasten with First-Template applied by Templater), then polls
-- until the file exists before opening it in Neovim.
map("n", "<leader>on", function()
  local vault = "/Users/ubd/Library/Mobile Documents/iCloud~md~obsidian/Documents/rhizome"
  local id = os.date("%Y%m%d-%H%M%S")
  local filepath = vault .. "/02_zettelkasten/" .. id .. ".md"
  vim.fn.system("open -g 'obsidian://adv-uri?vault=rhizome&commandid=zk-prefixer'")
  local attempts = 0
  local function try_open()
    attempts = attempts + 1
    if vim.fn.filereadable(filepath) == 1 then
      vim.defer_fn(function()
        vim.cmd("edit " .. vim.fn.fnameescape(filepath))
      end, 500)
    elseif attempts < 20 then
      vim.defer_fn(try_open, 300)
    else
      vim.notify("Timed out waiting for note: " .. filepath, vim.log.levels.WARN)
    end
  end
  vim.defer_fn(try_open, 300)
end, { desc = "Obsidian: new note" })

-- Templates (run on the active note in Obsidian, reload buffer when done)
map("n", "<leader>oZ", function()
  -- Apply zettel.js: renames file to title, sets 02_zet tag, formats structure
  vim.fn.system("open -g 'obsidian://adv-uri?vault=rhizome&commandid=templater-obsidian:08_templates/00_Zettelkasten_Template.md'")
  local path = vim.fn.expand("%:p")
  vim.defer_fn(function()
    if vim.fn.filereadable(path) == 1 then vim.cmd("checktime") end
  end, 2000)
end, { desc = "Obsidian: format zettel" })

map("n", "<leader>oM", function()
  -- Apply MOC template via moc.js
  vim.fn.system("open -g 'obsidian://adv-uri?vault=rhizome&commandid=templater-obsidian:08_templates/01_MOC_Template.md'")
  local path = vim.fn.expand("%:p")
  vim.defer_fn(function()
    if vim.fn.filereadable(path) == 1 then vim.cmd("checktime") end
  end, 2000)
end, { desc = "Obsidian: new MOC" })

-- Delete note
map("n", "<leader>oD", function()
  local path = vim.fn.expand("%:p")
  vim.ui.input({ prompt = "Delete " .. vim.fn.expand("%:t") .. "? (y/n): " }, function(input)
    if input == "y" then
      vim.fn.delete(path)
      vim.cmd("bd!")
    end
  end)
end, { desc = "Obsidian: delete note" })
