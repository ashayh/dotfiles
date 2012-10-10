## My dot files and how to install/use them.
 These are opinionated towards my setup: Ubuntu with XFCE Terminal and tmux. 

 The idea is to have a great environment for the shell, git and programming shell/web/ruby/rails in VIM.


### Installation:

##### Auto install script via wget or curl:
This also installs packages via apt.

`wget --no-check-certificate https://github.com/ashayh/dotfiles/raw/master/ubuntu_bootstrap.sh -O - | bash`
`curl -L https://github.com/ashayh/dotfiles/raw/master/ubuntu_bootstrap.sh | bash`

##### Manual Install:
* Try to read the script `create_dotfiles_etc`, and the variables used.
* Make sure you have `$CMDS` installed.
  Else, the script asks you to install them and exits.

* BEFORE you git clone,  and run `create_dotfiles_etc`,
  make sure `${HOME}/dotfiles` is absent.

  Then run:

  `cd ~ ; git clone https://github.com/ashayh/dotfiles.git ;`
* Run the script: `~/dotfiles/create_dotfiles_etc`
* **Note:** Any existing dot files will be moved to /tmp with a timestamp.

**Note:** After the `.vimrc` is installed, the first time you run VIM,
  the VIM addon manager will try to pull in all plugins:

  Answer `Y` here:
  `Clone VAM into ~/.vim/vim-addons?`

  After the first plugin is cloned, type `command` when the add on installer script pauses.
  Else, you have to press Enter to install all plugins.

  Type `command` here:
  `Press ENTER or type command to continue`

  **Note:** The cloning of all repos takes a few minutes, until which the screen sometimes may be blank/unresponsive.

### How does it work?
 Check the `create_dotfiles_etc` script for the variables described below.

* Checks if `~/dotfiles` exists, and is this repo (ashayh/dotfile.git)
* Checks if `$CMDS` exists, and exits if any is absent.
* Checks if `$MAKE_DIRS` exist, and creates if needed.
* Checks if `$DOTFILES` exist, and add if needed.
* Adds to .oh-my-zsh/custom via `$OH_MY_FILES`
* Adds to .oh-my-zsh/plugins via `$OH_MY_PLUGINS`
* Adds scripts to ~/bin from this repo via `$BIN_FILES`
**Note: Existing configs and dirs will be moved to /tmp**


#### .zshrc
This is standard rc from [.oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) with a few more plugins and shortcuts.

1. `Ctrl+f` to cut words on the cmd line up to the last slash.
2. `Ctrl+g` to cut words to last non-alpha character.
    * Useful for cutting up to `: ;` or similar.
3. Command is commented if preceded by `#`. Good to "store" cmds for later use.
4. Redirect fails to overwrite if file exists.
5. In addition to oh-my-zsh plugins, add syntax highlight and history search


#### .vimrc
Leader=`,`

Shortcuts direct in .vimrc:

1. `Ctrl+L` to refresh page and un-highlight search.
2. `F2` to toggle paste mode.
3. `F12` to toggle mouse.
4. Auto `chmod +x` based on she bang line.
5. Colorscheme=`jellybeans`
6. Tabs are space, with tabstops=2
7. Show trailing spaces with `•` .
8. .swp files placed in ~/.vim/tmp
9. `g{1,2}` to move between windows. `gx` to swap.
10. Capital Q and W made lower case. Disable visual mode with cap Q.

##### Read more about plugin based shortcuts on each plugins website.
Plugins managed in by VAM [vim addon manager](https://github.com/MarcWeber/vim-addon-manager.git).
My favourite plugin based shortcuts:

1. `,t= ,t>` Tabularize on `= and >`
2. `Ctrl+y` to show yankring plugin.
    * See yanks across seperate vim sessions.
    * yankring files in `~/.vim/`
3. Use `Tab` to complete in insert mode with SuperTab.
4. `,nn` Nerd tree toggle. NerdTree plugin
5. `cs"'` to change ("surround") double quotes with single, surround.vim plugin.
    * `csw"` to surround word with double quotes.
    * Use capital `S` in Visual mode to use surround.
      * Eg `S<div class="btn">` surrounds visual selection with a div.
5. `,,w` to move fast with EasyMotion
7. `Ctrl + A`  Increment num, `Ctrl + X` Decrement num, speeddating plugin.
8. Syntax check for various languages with syntastic plugin.
9. Add `end` and close brackets/quotes in languages etc.
10. `,t` for Cmd-T. Choose file then `Ctrl+t or s or v` to open it in a Tab, os split window.
