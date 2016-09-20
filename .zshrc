# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="ashay"

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

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
PATH=$PATH:$HOME/.rvm/bin

export TERM='screen-256color'

export PATH=$PATH:~/bin

export AWS_IAM_HOME=${HOME}/aws/iamcli
export EC2_HOME=${HOME}/aws/ec2-api-tools

export PATH=$PATH:${EC2_HOME}/bin:${AWS_IAM_HOME}/bin

export AWS_CREDENTIAL_FILE=${HOME}/aws/.aws-creds

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

#ZSH_HIGHLIGHT_STYLES+=(
#  default                       'none'
#  unknown-token                 'fg=red,bold'
#  reserved-word                 'fg=yellow'
#  alias                         'fg=none,bold'
#  builtin                       'fg=none,bold'
#  function                      'fg=none,bold'
#  command                       'fg=none,bold'
#  hashed-command                'fg=none,bold'
#  path                          'fg=cyan'
#  globbing                      'fg=cyan'
#  history-expansion             'fg=blue'
#  single-hyphen-option          'fg=magenta'
#  double-hyphen-option          'fg=magenta'
#  back-quoted-argument          'fg=magenta,bold'
#  single-quoted-argument        'fg=green'
#  double-quoted-argument        'fg=green'
#  dollar-double-quoted-argument 'fg=cyan'
#  back-double-quoted-argument   'fg=cyan'
#  assign                        'none'
#)

ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[globbing]=fg=green,bold
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=magenta,bold
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=magenta,bold
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=magenta,bold

ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')

zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:descriptions' format $'%{\e[0;31m%}completing %B%d%b%{\e[0m%}'''

# Invoke GnuPG-Agent the first time we login.
# If it exists, use this:
# if test -f $HOME/.gpg-agent-info && \
#   kill -0 `grep '^GPG_AGENT_INFO' $HOME/.gpg-agent-info | cut -d: -f 2` 2>/dev/null; then
#   GPG_AGENT_INFO=`cat $HOME/.gpg-agent-info | cut -c 16-`
#   GPG_TTY=`tty`
#   export GPG_TTY
#   export GPG_AGENT_INFO
# # Otherwise, it either hasn't been started, or was killed:
# else
#   eval `gpg-agent --daemon --no-grab --write-env-file $HOME/.gpg-agent-info`
#   GPG_TTY=`tty`
#   export GPG_TTY
#   export GPG_AGENT_INFO
# fi

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

export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS='-XF -R '

# go lang
if [[ -s ~/.gvm/scripts/gvm ]] ; then
  source ~/.gvm/scripts/gvm
  export GO15VENDOREXPERIMENT=1
  gvm use go1.7
fi
# [[ -d ~/go ]] || mkdir -p ~/go
# export GOPATH="~/go"
export PATH=$PATH:${GOPATH}/bin

if which chef >/dev/null 2>&1
then
  eval "$(chef shell-init $(basename $SHELL))"
  echo "not using Chef ruby as brew vim does not use it."
  export PATH=/usr/local/bin/:${PATH}
  unset GEM_ROOT
  unset GEM_HOME
  unset GEM_PATH
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

export PATH=$PATH:$HOME/.vim/.git-radar

CHRUBY_FILES=(/usr/local/share/chruby/chruby.sh /usr/local/share/chruby/auto.sh)
for i in ${CHRUBY_FILES[@]}
do
  if [[ -f ${i} ]]; then
    source ${i}
  fi
done

if [[ -f /usr/local/bin/virtualenvwrapper.sh ]]; then
  source /usr/local/bin/virtualenvwrapper.sh
fi

if [[ -n "${GOPATH+x}" ]] ; then
  [[ -d $GOPATH/src/github.com/ashayh ]] || mkdir -p $GOPATH/src/github.com/ashayh
  [[ -d $GOPATH/src/bitbucket.org/ashayh ]] || mkdir -p $GOPATH/src/github.com/ashayh
  export PATH=${PATH}:${HOME}/go/bin
  export GO15VENDOREXPERIMENT=1
fi
