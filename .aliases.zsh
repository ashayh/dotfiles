# Push and pop directories on directory stack
alias pu='pushd'
alias po='popd'

# Basic directory operations
alias ...='cd ../..'
alias -- -='cd -'

# Super user
alias _='sudo'

#alias g='grep -in'

# Show history
alias history='fc -l 1'

alias afind='ack-grep -il'

if [ "$TERM" != "dumb" ]; then
  eval "`dircolors -b`"
  alias ls='ls --color=auto'
  #alias dir='ls --color=auto --format=vertical'
  #alias vdir='ls --color=auto --format=long'
fi

alias ls='ls --color=auto'
alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'
# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -laF'
alias lsa='ls -lah'
alias lh='ls -lh'
alias sl=ls # often screw this up
alias mx='chmod a+x'
alias 000='chmod 000'
alias 644='chmod 644'
alias 755='chmod 755'

alias grep='grep --color=auto'
alias rbgrep='grep -R --include="*.rb" '
alias ignore_comment_grep='grep -E -v "^#|^$"'

alias pgrepf='pgrep -fl'
alias faux='ps faux'

alias lnetstat='netstat -letupn'
alias anetstat='netstat -an'

alias treed='tree -fFAd'
alias tree='tree -fFA'

alias git='nocorrect git'
alias glg='git lg'
alias gco='git co'
alias gss='git ss'
alias glg='git lg'
alias gdiff='git diff'

# TODO:
# Add puppet related aliases

kd () {
  lineno=$1
  if [[ ${lineno} == "" ]]
  then
    echo "Provide line no to delete."
  else
    sed -i ${lineno}d ${HOME}/.ssh/known_hosts
  fi
}


ssh_root ()  {
  host=$1
  if [[ ${host} == "" ]]
  then
    echo "Provide hostname no to connect to."
  else
    ssh -q -X -l root ${host}
  fi
}

cdd () { if [ -d "$1" ]; then cd "$1"; else cd $(dirname "$1"); fi; }

# A shortcut function that simplifies usage of xclip.
# - Accepts input from either stdin (pipe), or params.
# ------------------------------------------------
cb() {
  local _scs_col="\e[0;32m"; local _wrn_col='\e[1;31m'; local _trn_col='\e[0;33m'
  # Check that xclip is installed.
  if ! type xclip > /dev/null 2>&1; then
    echo -e "$_wrn_col""You must have the 'xclip' program installed.\e[0m"
  # Check user is not root (root doesn't have access to user xorg server)
  elif [[ "$USER" == "root" ]]; then
    echo -e "$_wrn_col""Must be regular user (not root) to copy a file to the clipboard.\e[0m"
  else
    # If no tty, data should be available on stdin
    if ! [[ "$( tty )" == /dev/* ]]; then
      input="$(< /dev/stdin)"
    # Else, fetch input from params
    else
      input="$*"
    fi
    if [ -z "$input" ]; then  # If no input, print usage message.
      echo "Copies a string to the clipboard."
      echo "Usage: cb <string>"
      echo "       echo <string> | cb"
    else
      # Copy input to clipboard
      echo -n "$input" | xclip -selection c
      # Truncate text for status
      if [ ${#input} -gt 80 ]; then input="$(echo $input | cut -c1-80)$_trn_col...\e[0m"; fi
      # Print status.
      echo -e "$_scs_col""Copied to clipboard:\e[0m $input"
    fi
  fi
}
# Aliases / functions leveraging the cb() function
# ------------------------------------------------
# Copy contents of a file
function cbf() { cat "$1" | cb; }
# Copy SSH public key
alias cbssh="cb ~/.ssh/id_rsa.pub"
# Copy current working directory
alias cbwd="pwd | cb"
# Copy most recent command in bash history
alias cbhs="cat $HISTFILE | tail -n 1 | cb"

alias pryc="pry -r ./config/environment"
alias clijson="ruby -e 'require \"rubygems\";require \"json\"; require \"ap\"; j = JSON.parse(STDIN.gets); ap j'"
alias es_doc_count="ruby -e 'require \"rubygems\";require \"json\"; require \"ap\"; j = JSON.parse(STDIN.gets); ap j[\"_all\"][\"primaries\"][\"docs\"]'"

alias hh="\history -i 0 -1"

alias faux="ps faux"

alias pgrep="pgrep -f"

alias paux="ps aux --noheader |  awk '$3 > 1.0 || $8 !~ /S/ {print $3,$8,$11}' | sort -nr"
