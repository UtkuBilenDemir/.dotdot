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

### On the Snippet Question
Managing completion setup became a burden, there are way too many moving parts and not enough standardised approaches. But for anyone trying to stay afloat in this ecosystem especially with lazyvim moving from [nvim-cmp](https://github.com/hrsh7th/nvim-cmp){:target="_blank"} to [blink.cmp](https://github.com/Saghen/blink.cmp){:target="_blank"}, here is how I am surviving in current meta.

*Disclaimer: This completion/snippet setup is not optimised, and contains lots of unnecessary copy-paste because I didn't want to find out which parts of the copied lines were actually necessary. Use it if you are in a just-make-it-work-alredy mindset.*

#### Sources:
- [What is blink.cmp and how to configure it | linkarzu](https://www.youtube.com/watch?v=sBbplGeFffY
){:target="_blank"}
- [ Custom Snippets in Neovim and Configure completion priority on nvim-cmp  |
linkarzu](https://www.youtube.com/watch?v=GxnBIRl9UmA){:target="_blank"}

#### How do the custom snippets work:
There are main custom snippet sources in this setup:
1. **LuaSnip**: Some of the custom snippets are defined in LuaSnip's own plugin config, see the examples there. Only setting on blink.cmp's side is that LuaSnip is defined as a dependency.
2. **nvim-scissors**: This one is a plugin that allows you to add new snippets
   on the run. These are exclusively defined as json snippets. I couldn't find
   a way to integrate these with the LuaSnip custom snippets, therefore they
are located in `./lua/snips`. Note that a `package.json` file in this directory
is usually necessary. This path has been indicated in blink.lua config.




![Current Terminal Asthetics](./terminal.png)
![](./kitty_setup.png)



































