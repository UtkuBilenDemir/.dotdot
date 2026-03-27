# .dotdot/nvim

Personal Neovim config based on [LazyVim](https://lazyvim.github.io).

## Stack

| Layer | Plugin | Role |
|-------|--------|------|
| Editor base | [LazyVim](https://github.com/LazyVim/LazyVim) | Sensible defaults, extras system |
| Completion | [blink.cmp](https://github.com/saghen/blink.cmp) | LSP + snippet completion menu |
| Snippets | [mini.snippets](https://github.com/echasnovski/mini.snippets) | Snippet expansion and tabstop navigation |
| Snippet UI | [nvim-scissors](https://github.com/chrisgrieser/nvim-scissors) | Create and edit snippets in a floating buffer |
| LaTeX | [vimtex](https://github.com/lervag/vimtex) | LaTeX editing and compilation |
| Notes | [obsidian.nvim](https://github.com/epwalsh/obsidian.nvim) | Obsidian vault integration |
| Database | [vim-dadbod](https://github.com/tpope/vim-dadbod) | SQL client |

## Snippet System

Snippets are VSCode JSON files in `lua/snips/`, one per filetype.

```
lua/snips/
  package.json      ← filetype → file mapping
  tex.json          ← LaTeX snippets
  markdown.json     ← Markdown snippets
```

**Add a snippet:** `:ScissorsAddNewSnippet`
**Edit a snippet:** `:ScissorsEditSnippet`

### Visual wrapping

Select text → `c` → type trigger → Enter. Snippets that wrap use `${1:$TM_SELECTED_TEXT}` in their body.

### Snippet format

```json
{
  "name": {
    "prefix": "trigger",
    "description": "description shown in menu",
    "body": ["line one $1", "line two", "$0"]
  }
}
```

Tabstops: `$1` `$2` `$0` (final position). Multiline: array of strings. Mirrored: repeat the same number. Visual wrap: `${1:$TM_SELECTED_TEXT}`.

### Keymaps

| Key | Action |
|-----|--------|
| `Tab` | Jump to next tabstop |
| `S-Tab` | Jump to previous tabstop |
| `CR` | Accept first completion suggestion |
| `S-CR` | Cancel menu and insert newline |
| `C-j` / `C-k` | Navigate completion menu |
| `C-e` | Hide completion menu |

## Structure

```
lua/
  config/
    autocmds.lua    ← custom autocmds (LazyVim convention)
    keymaps.lua     ← custom keymaps
    options.lua     ← vim options
  plugins/
    blink.lua       ← completion config
    mini-snippets.lua ← snippet engine
    nvim-scissors.lua ← snippet editor UI
    obsidian.lua    ← notes integration
    vimtex.lua      ← LaTeX
    csvview.lua     ← CSV viewer
  snips/
    package.json    ← snippet index
    tex.json        ← LaTeX snippets
    markdown.json   ← Markdown snippets
lazyvim.json        ← active LazyVim extras
```

## Sync

`~/.config/nvim` is a symlink to `~/Projects/.dotdot/nvim`.
Edits on the iCloud path (`~/Library/Mobile Documents/com~apple~CloudDocs/Projects/.dotdot/nvim`) sync automatically.
