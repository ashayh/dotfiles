# Setup fzf
# ---------
if [[ ! "$PATH" == */home/ashay/.fzf/bin* ]]; then
  export PATH="$PATH:/home/ashay/.fzf/bin"
fi

# Man path
# --------
if [[ ! "$MANPATH" == */home/ashay/.fzf/man* && -d "/home/ashay/.fzf/man" ]]; then
  export MANPATH="$MANPATH:/home/ashay/.fzf/man"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/ashay/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/ashay/.fzf/shell/key-bindings.zsh"

