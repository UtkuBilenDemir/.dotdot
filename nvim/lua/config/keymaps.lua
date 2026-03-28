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

local vault     = "/Users/ubd/Library/Mobile Documents/iCloud~md~obsidian/Documents/rhizome"
local zetteldir = vault .. "/02_zettelkasten"

-- Lock the current buffer and show a status message while Obsidian works.
-- Returns the locked buf handle so the caller can unlock it.
local function lock(msg)
  local buf = vim.api.nvim_get_current_buf()
  pcall(function() vim.bo[buf].modifiable = false end)
  vim.api.nvim_echo({ { "  Obsidian: " .. msg .. "  ", "WarningMsg" } }, false, {})
  return buf
end

local function unlock(buf)
  vim.api.nvim_echo({ { "" } }, false, {})
  if buf and vim.api.nvim_buf_is_valid(buf) then
    pcall(function() vim.bo[buf].modifiable = true end)
  end
end

-- Find the most recently modified .md file in dir that was touched after
-- `since` (os.time() value). Returns nil if none found yet.
local function newest_after(dir, since)
  local best, best_time = nil, since - 1
  for _, f in ipairs(vim.fn.globpath(dir, "*.md", false, true)) do
    local t = vim.fn.getftime(f)
    if t > best_time then best_time = t; best = f end
  end
  return best
end

-- After `delay_ms`, poll every 500ms until a file newer than `since` appears
-- in `dir`, then open it. Unlocks `buf` and clears the status message.
local function open_newest_after(dir, since, buf, delay_ms)
  vim.defer_fn(function()
    local attempts = 0
    local function poll()
      attempts = attempts + 1
      if attempts > 40 then
        unlock(buf)
        vim.api.nvim_echo({ { "  Obsidian: timed out", "ErrorMsg" } }, false, {})
        return
      end
      local f = newest_after(dir, since)
      if f then
        unlock(buf)
        vim.cmd("edit " .. vim.fn.fnameescape(f))
      else
        vim.defer_fn(poll, 500)
      end
    end
    poll()
  end, delay_ms)
end

-- Navigation
map("n", "<leader>oo", "<cmd>ObsidianQuickSwitch<cr>", { desc = "Obsidian: quick switch" })
map("n", "<leader>op", function()
  local filepath = vim.fn.expand("%:p"):gsub(vim.pesc(vault .. "/"), "")
  vim.fn.system("open 'obsidian://adv-uri?vault=rhizome&filepath=" .. filepath .. "'")
end, { desc = "Obsidian: open in Obsidian" })

-- New note: trigger zk-prefixer, wait 4s for Templater to finish, open result.
map("n", "<leader>on", function()
  local since = os.time()
  local buf = lock("creating note…")
  vim.fn.system("open -g 'obsidian://adv-uri?vault=rhizome&commandid=zk-prefixer'")
  open_newest_after(zetteldir, since, buf, 4000)
end, { desc = "Obsidian: new note" })

-- Zettel template: wait 4s then open the newest file (template renames current note).
map("n", "<leader>oZ", function()
  local since = os.time()
  local buf = lock("applying zettel template…")
  vim.fn.system("open -g 'obsidian://adv-uri?vault=rhizome&commandid=templater-obsidian:08_templates/00_Zettelkasten_Template.md'")
  open_newest_after(zetteldir, since, buf, 4000)
end, { desc = "Obsidian: format zettel" })

-- MOC template: same pattern.
map("n", "<leader>oM", function()
  local since = os.time()
  local buf = lock("applying MOC template…")
  vim.fn.system("open -g 'obsidian://adv-uri?vault=rhizome&commandid=templater-obsidian:08_templates/01_MOC_Template.md'")
  open_newest_after(zetteldir, since, buf, 4000)
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
