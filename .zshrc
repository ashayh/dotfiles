# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="powerlevel10k/powerlevel10k"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git ruby rails gem bundler rvm vagrant zsh-syntax-highlighting zsh-history-substring-search)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

if [[ -d /usr/libexec/java_home ]] ; then
  export JAVA_HOME=$(/usr/libexec/java_home)
fi

export TERM='tmux-256color'

export PATH=$PATH:~/bin

zlewidget() {
 zle -N $2 $3
 bindkey $1 $2
}

bindkey '\e.' insert-last-word

autoload -U backward-kill-word-match
zle -N backward-kill-word-space backward-kill-word-match 
zstyle ':zle:backward-kill-word-space' word-style space
bindkey '^w' backward-kill-word-space

backward-delete-to-slash() {
  integer pos=$CURSOR
  while (( pos > 1 )); do
    if [[ $LBUFFER[--pos] = / ]]; then
      LBUFFER=${LBUFFER[1,pos]}
      return 0
    fi
  done
  return 1
}
zle -N backward-delete-to-slash
bindkey '^f' backward-delete-to-slash

bindkey '^g' backward-kill-word

#function command_not_found_handler() {echo "command not found: $*";}

setopt interactivecomments
setopt noclobber

autoload -U zargs

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[globbing]=fg=green,bold
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=magenta,bold
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=magenta,bold
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=magenta,bold

ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')

zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:descriptions' format $'%{\e[0;31m%}completing %B%d%b%{\e[0m%}'''

tmuxHashColor() {
  local hsh=$(echo $1 | cksum | cut -d ' ' -f 1)
  local num=$(expr $hsh % 255)
  echo "colour$num"
}

ns() {
  if [ -z $1 ]; then
    1=$(basename $(pwd))
  fi
  tmux new-session -d -s $1
  local color=$(tmuxHashColor $1)
  tmux send-keys -t $1 "tmux set-option status-bg $color" C-m
  tmux send-keys -t $1 "clear" C-m
  tmux attach -t $1
}

export LESSOPEN="| ~/bin/src-hilite-lesspipe.sh %s"
export LESS='-XF -R '

# go lang
if [[ -s ~/.gvm/scripts/gvm ]] ; then
  source ~/.gvm/scripts/gvm
  export GO15VENDOREXPERIMENT=1
  gvm use go1.10
fi
export PATH=$PATH:${GOPATH}/bin

if [[ -n "${GOPATH+x}" ]] ; then
  [[ -d $GOPATH/src/github.com/ashayh ]] || mkdir -p $GOPATH/src/github.com/ashayh
  [[ -d $GOPATH/src/bitbucket.org/ashayh ]] || mkdir -p $GOPATH/src/github.com/ashayh
  export PATH=${PATH}:${HOME}/go/bin
fi

DISABLE_AUTO_TITLE="true"

setTerminalText () {
  # echo works in bash & zsh
  local mode=$1 ; shift
  echo -ne "\033]$mode;$@\007"
}
stt_both  () { setTerminalText 0 $@; }
stt_tab   () { setTerminalText 1 $@; }
stt_title () { setTerminalText 2 $@; }

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ -f /usr/local/bin/virtualenvwrapper.sh ]]; then
  source /usr/local/bin/virtualenvwrapper.sh
fi

if [[ -f /etc/bash_completion.d/g4d ]] ; then
  source /etc/bash_completion.d/g4d
fi

EDITOR=nvim
GIT_EDITOR=nvim

alias vim=nvim
alias vi=nvim
alias k=kubectl

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[[ ! -f  ~/.oh-my-zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] || source ~/.oh-my-zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

command -v kubecolor >/dev/null 2>&1 && alias kubectl="kubecolor"

alias kopen="aws-keycloak open ${1}"

command -v kubectl >/dev/null 2>&1 && source <(kubectl completion zsh)
