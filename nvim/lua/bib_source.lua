-- blink.cmp source: citekey completions from a BibTeX file.
-- Triggered by '@' in markdown buffers.

local source = {}
local bibpath = vim.fn.expand("~/Bibliotheca/bib.bib")
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
        filterText = key,   -- blink matches typed text after @ against this
        insertText = "@" .. key,
        kind = 9,
      })
    end
  end
  cached_items = items
  cached_mtime = mtime
  return items
end

function source.new(opts, config)
  return setmetatable({}, { __index = source })
end

function source:get_trigger_characters()
  return { "@" }
end

function source:should_show_items(ctx, items)
  local col = ctx.cursor[2]
  local line = vim.api.nvim_buf_get_lines(ctx.bufnr, ctx.cursor[1] - 1, ctx.cursor[1], false)[1] or ""
  return line:sub(1, col):match("@%S*$") ~= nil
end

function source:get_completions(ctx, callback)
  local ok, items = pcall(parse_bib)
  callback({
    items = ok and items or {},
    is_incomplete_forward = false,
    is_incomplete_backward = false,
  })
end

function source:resolve(item, callback)
  local key = item.label:sub(2) -- strip leading @
  local f = io.open(bibpath, "r")
  if not f then callback(item); return end
  local content = f:read("*all")
  f:close()

  -- Extract the entry block for this key
  local entry = content:match("@%w+%s*{%s*" .. key .. "%s*,(.-)\n}")
               or content:match("@%w+%s*{%s*" .. key .. "%s*,(.-)%s*\n@")

  if entry then
    -- Extract a field using balanced-brace matching, then strip LaTeX markup
    local function field(name)
      local val = entry:match(name .. "%s*=%s*(%b{})")
               or entry:match(name .. "%s*=%s*\"(.-)\"")
               or entry:match(name .. "%s*=%s*(%d+)")
      if not val then return nil end
      if val:sub(1,1) == "{" then val = val:sub(2, -2) end -- strip outer {}
      val = val:gsub("\\%a+%s*(%b{})", function(b) return b:sub(2,-2) end) -- \cmd{x}→x
      val = val:gsub("[{}]", "")   -- leftover braces
      val = val:gsub("\\\\", " ")  -- LaTeX line breaks
      val = val:gsub("~", " ")     -- non-breaking spaces
      val = val:gsub("%s+", " "):match("^%s*(.-)%s*$")
      return val ~= "" and val or nil
    end
    local title  = field("[Tt]itle")
    local author = field("[Aa]uthor")
    local year   = field("[Yy]ear")
    local parts  = {}
    if title  then table.insert(parts, "**" .. title .. "**") end
    if author then table.insert(parts, author) end
    if year   then table.insert(parts, year) end
    if #parts > 0 then
      item.documentation = { kind = "markdown", value = table.concat(parts, "\n\n") }
    end
  end

  callback(item)
end

return source
