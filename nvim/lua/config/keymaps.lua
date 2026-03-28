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
--
-- For commands that create or modify notes via Templater:
--   1. Snapshot existing files in the vault dir before triggering.
--   2. Show a loading message so the user knows to wait.
--   3. Poll every 300ms: wait for a new/changed file whose content no longer
--      contains Templater tags (<%) — that signals Templater is done.
--   4. Open the file and clear the loading message.

local vault    = "/Users/ubd/Library/Mobile Documents/iCloud~md~obsidian/Documents/rhizome"
local zetteldir = vault .. "/02_zettelkasten"

local lock_buf = nil

local function loading(msg)
  vim.api.nvim_echo({ { "  Obsidian: " .. msg .. "  ", "WarningMsg" } }, false, {})
  -- Lock current buffer so user can't edit while waiting
  lock_buf = vim.api.nvim_get_current_buf()
  vim.bo[lock_buf].modifiable = false
end

local function loading_clear()
  vim.api.nvim_echo({ { "" } }, false, {})
  if lock_buf and vim.api.nvim_buf_is_valid(lock_buf) then
    pcall(function() vim.bo[lock_buf].modifiable = true end)
  end
  lock_buf = nil
end

-- Open filepath once Templater is done.
-- Waits 1.5s minimum (Templater needs time to write the raw template),
-- then polls until size is stable and no <% tags remain.
local function open_when_ready(filepath)
  vim.defer_fn(function()
    local attempts = 0
    local last_size = -1
    local function poll()
      attempts = attempts + 1
      if attempts > 40 then
        loading_clear()
        vim.api.nvim_echo({ { "  Obsidian: timed out waiting for Templater", "ErrorMsg" } }, false, {})
        return
      end
      if vim.fn.filereadable(filepath) == 0 then
        vim.defer_fn(poll, 300)
        return
      end
      local size = vim.fn.getfsize(filepath)
      if size <= 0 or size ~= last_size then
        last_size = size
        vim.defer_fn(poll, 300)
        return
      end
      local ok, lines = pcall(vim.fn.readfile, filepath)
      if not ok then
        vim.defer_fn(poll, 300)
        return
      end
      if table.concat(lines, "\n"):find("<%", 1, true) then
        vim.defer_fn(poll, 300)
      else
        loading_clear()
        vim.cmd("edit " .. vim.fn.fnameescape(filepath))
      end
    end
    poll()
  end, 1500)
end

-- Poll for a file in dir not present in snapshot, then open_when_ready.
-- Used for new notes (genuinely new filename expected).
local function open_new_file(dir, snapshot)
  local attempts = 0
  local function poll()
    attempts = attempts + 1
    if attempts > 50 then
      vim.api.nvim_echo({ { "  Obsidian: timed out waiting for new file", "ErrorMsg" } }, false, {})
      return
    end
    for _, f in ipairs(vim.fn.globpath(dir, "*.md", false, true)) do
      if not snapshot[f] then
        open_when_ready(f)
        return
      end
    end
    vim.defer_fn(poll, 300)
  end
  vim.defer_fn(poll, 300)
end

-- Watch oldpath disappear (renamed by template), then open the most recently
-- modified file in dir. Falls back to checktime if file survives (modified in place).
local function open_after_rename(dir, oldpath)
  local attempts = 0
  local function poll()
    attempts = attempts + 1
    if attempts > 50 then
      -- Fallback: file was probably modified in place, just reload
      loading_clear()
      pcall(vim.cmd, "checktime")
      return
    end
    if vim.fn.filereadable(oldpath) == 0 then
      -- File gone — find newest file in dir
      local files = vim.fn.globpath(dir, "*.md", false, true)
      table.sort(files, function(a, b) return vim.fn.getftime(a) > vim.fn.getftime(b) end)
      if #files > 0 then
        open_when_ready(files[1])
      end
    else
      vim.defer_fn(poll, 300)
    end
  end
  vim.defer_fn(poll, 300)
end

-- Navigation
map("n", "<leader>oo", "<cmd>ObsidianQuickSwitch<cr>", { desc = "Obsidian: quick switch" })
map("n", "<leader>op", function()
  local filepath = vim.fn.expand("%:p"):gsub(vim.pesc(vault .. "/"), "")
  vim.fn.system("open 'obsidian://adv-uri?vault=rhizome&filepath=" .. filepath .. "'")
end, { desc = "Obsidian: open in Obsidian" })

-- New note: trigger zk-prefixer, wait for Templater to finish, open result.
map("n", "<leader>on", function()
  local snapshot = {}
  for _, f in ipairs(vim.fn.globpath(zetteldir, "*.md", false, true)) do
    snapshot[f] = true
  end
  loading("creating note…")
  vim.fn.system("open -g 'obsidian://adv-uri?vault=rhizome&commandid=zk-prefixer'")
  open_new_file(zetteldir, snapshot)
end, { desc = "Obsidian: new note" })

-- Zettel template: renames current note via Templater. Watches old path
-- disappear then opens the newest file in the dir.
map("n", "<leader>oZ", function()
  local oldpath = vim.fn.expand("%:p")
  loading("applying zettel template…")
  vim.fn.system("open -g 'obsidian://adv-uri?vault=rhizome&commandid=templater-obsidian:08_templates/00_Zettelkasten_Template.md'")
  open_after_rename(zetteldir, oldpath)
end, { desc = "Obsidian: format zettel" })

-- MOC template: same pattern.
map("n", "<leader>oM", function()
  local oldpath = vim.fn.expand("%:p")
  loading("applying MOC template…")
  vim.fn.system("open -g 'obsidian://adv-uri?vault=rhizome&commandid=templater-obsidian:08_templates/01_MOC_Template.md'")
  open_after_rename(zetteldir, oldpath)
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
