# utku - dotfiles

> **os**: macOS 15 / arm64
> **terminal**: iTerm2
> **shell**: zsh

Using a modified [LazyVim](https://lazyvim.org) installation.

### On the Snippet Question
Snippets are managed with [mini.snippets](https://github.com/echasnovski/mini.snippets)
and exposed in [blink.cmp](https://github.com/Saghen/blink.cmp) via the `mini_snippets` preset.

Snippet files live in `nvim/lua/snips/<filetype>.json` (VSCode JSON format).
New snippets can be added on the fly with [nvim-scissors](https://github.com/chrisgrieser/nvim-scissors).

**Visual wrapping**: select text in visual mode → `c` → type trigger → accept from completion menu.

![Current Terminal Aesthetics](./terminal.png)
