# utku - dotfiles

> **os/cpu-architecture**: macos 12.1/arm64
> 
> **terminal**: alacritty
> 
> **shell**: zsh -> tmux

## Notes

* Neovim lua config is heavily copypasted from [ChristianChiarulli's repo](https://github.com/LunarVim/Neovim-from-scratch).

* Treesitter messes up the intendation. I've already disabled some of the
  filetypes in `./nvim/lua/ubd/treesitter.lua` but it might be better to disable
  it completely. Calling `set indentexpr` in neovim shows where the intendation
  comes from.

* tmux messes up the color spectrum of alacritty which hits neovim pretty hard.
  What is happening:

  * tmux doesn't recognize *alacritty* register ==> once tmux is activated
    alacritty will be registered either `xterm-256color`, `screen-256color` or
    simply as `screen`.
  
  * Neovim will never stop complaining that `$TERM` output is different than the
    actual register.

  * Hardcoding terminal name in `alacritty.yml` and `tmux.conf` does not help
    but defining it in `.zshrc` somehow helps *temporarily*.

  * TODO: Right now, it is broken again without changing anything; investigate
    the situation.
