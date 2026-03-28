-- blink.cmp source: citekey completions from a BibTeX file.
-- Triggered by '@' in markdown buffers.

local source = {}
local bibpath = vim.fn.expand("~/biblotheca/bib.bib")
local cached_items = nil
local cached_mtime = -1

local function parse_bib()
  local mtime = vim.fn.getftime(bibpath)
  if cached_items and mtime == cached_mtime then
    return cached_items
  end
  local items = {}
  local f = io.open(bibpath, "r")
  if not f then return items end
  local content = f:read("*all")
  f:close()
  for key in content:gmatch("@%w+%s*{%s*([^,]+),") do
    key = key:match("^%s*(.-)%s*$")
    if key ~= "" then
      table.insert(items, {
        label = "@" .. key,
        insertText = "@" .. key,
        kind = require("blink.cmp.types").CompletionItemKind.Reference,
      })
    end
  end
  cached_items = items
  cached_mtime = mtime
  return items
end

function source.new()
  return setmetatable({}, { __index = source })
end

function source:get_trigger_characters()
  return { "@" }
end

function source:get_completions(ctx, callback)
  local ok, items = pcall(parse_bib)
  callback({
    items = ok and items or {},
    is_incomplete_forward = false,
    is_incomplete_backward = false,
  })
end

return source
