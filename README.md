# utku - dotfiles

> **os/cpu-architecture**: macos 15.0.1/arm64
> 
> **terminal**: ~~alacritty kitty~~ iTerm2
> 
> **shell**: zsh ~~-> tmux (friendship ended with tmux, now kitty integrated
> multiplexer is my best friend)~~, using iTerm's own split options.

## Notes

* Using a modified lazyvim installation.
* I won't bother myself with TreeSitter bugs.
* ~~tmux doesn't play well with the color spectrum of alacritty which hits neovim pretty hard.
  What is happening:~~

  * ~~tmux doesn't recognize *alacritty* register ==> once tmux is activated
    alacritty will be registered either `xterm-256color`, `screen-256color` or
    simply as `screen`.~~
  
  * ~~Neovim will never stop complaining that `$TERM` output is different than the
    actual register.~~

  * ~~Hardcoding terminal name in `alacritty.yml` and `tmux.conf` does not help
    but defining it in `.zshrc` somehow helps *temporarily*.~~

   * [x] TODO: Right now, it is broken again without changing anything; investigate the situation.

    * ~~~Solution was simple: switch to iTerm2~~~
    * ~~Alacritty now works well with tmux~~
    * ~~Kitty is also set up  with this configuration but doesn't seem appealing
      to me yet~~
    * Alacritty+tmux struggling to point to the Conda-Env. compiler ==> moving
      to Kitty.
    * **All of these are replaced by the serenity of iTerm**

* [x] TODO: translate ultisnips to lua

  * [Here is an amazing script that handles the translation flawlessly](https://github.com/L3MON4D3/LuaSnip/issues/201#issuecomment-950132369)

  * [x] TODO: I've added the translated lines into the latex snippets of
    `friendly-snippets` but I'm pretty sure there is a better location/method
    for this. Find it.
  * **Abandoned luaSnip, seems to be the collection of snippets tools in
  lazyvim are enough**

![Current Terminal Asthetics](./terminal.png)
![](./kitty_setup.png)
