local return_code="%(?..%{$fg_bold[red]%}%? ↵%{$reset_color%})"

function rvm_p_info() {
  ruby_version=$(~/.rvm/bin/rvm-prompt 2> /dev/null) || return
  echo "[$ruby_version] "
}

PROMPT='$fg_bold[green][ $FG[105]%D{%a %b-%e-%Y} $FG[192] %* $fg_bold[green]]$([[ -f .git/config ]] && git-radar --zsh --fetch)$fg[magenta] $(~/.rvm/bin/rvm-prompt 2> /dev/null) $fg[cyan]%n@$fg[green]%m: $FG[209]%~ $reset_color
# '

RPS1="${return_code}"

# git theming
ZSH_THEME_GIT_PROMPT_PREFIX="$FG[166][$FG[135]"
ZSH_THEME_GIT_PROMPT_SUFFIX="]"
ZSH_THEME_GIT_PROMPT_CLEAN="$fg[green]✔$FG[166]"
ZSH_THEME_GIT_PROMPT_DIRTY="$fg[red]✗$FG[166]"
