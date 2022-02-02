# utku - dotfiles

> **os/cpu-architecture**: macos 12.1/arm64
> 
> **terminal**: ~~alacritty~~ tmux
> 
> **shell**: zsh -> tmux

## Notes

* Neovim lua config is heavily copypasted from [ChristianChiarulli's repo](https://github.com/LunarVim/Neovim-from-scratch).

* Treesitter messes up the indentation. I've already disabled some of the
  filetypes in `./nvim/lua/ubd/treesitter.lua` but it might be better to disable
  it completely. Calling `set indentexpr` in neovim shows where the indentation
  comes from.

* ~~tmux messes up the color spectrum of alacritty which hits neovim pretty hard.
  What is happening:~~

  * ~~tmux doesn't recognize *alacritty* register ==> once tmux is activated
    alacritty will be registered either `xterm-256color`, `screen-256color` or
    simply as `screen`.~~
  
  * ~~Neovim will never stop complaining that `$TERM` output is different than the
    actual register.~~

  * ~~Hardcoding terminal name in `alacritty.yml` and `tmux.conf` does not help
    but defining it in `.zshrc` somehow helps *temporarily*.~~

  * [x] TODO: Right now, it is broken again without changing anything; investigate
    the situation.

    * Solution was simple: switch to iTerm2

* [x] TODO: translate ultisnips to lua

  * [Here is an amazing script that handles the translation flawlesly](https://github.com/L3MON4D3/LuaSnip/issues/201#issuecomment-950132369)

  * [ ] TODO: I've added the translated lines into the latex snippets of
    `friendly-snippets` but I'm pretty sure there is a better location/method
    for this. Find it.

* `tmux_line` configs are from [sainhe's dotfiles](https://github.com/sainnhe/dotfiles)
