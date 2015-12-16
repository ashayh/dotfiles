if which brew &>/dev/null ; then
  :
else
  echo "brew is not present, is this Mac?"
  if [ "$(uname)" == "Darwin" ]
  then
    echo " This is Mac...trying to install brew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    if [[ $? -eq 0 ]] ; then
      echo "brew install successful..."
    else
      echo "brew install failed..exiting..."
      exit 1
    fi
  fi
fi

export HOMEBREW_GITHUB_API_TOKEN=XX

PKGS=(curl git grc mercurial source-highlight tmux wget jq hub gnu-sed cheat awscli autossh packer grc vimpager git-extras nmap httpie brew-cask ipcalc unrar wireshark tree ssh-copy-id awscli ag fzf shellcheck)
echo
echo "Installing ${PKGS[*]}..."

brew install -y ${PKGS[*]}

if [[ $? -eq 0 ]] ; then
  echo "brew install ${PKGS[*]} successful..."
else
  echo "brew install ${PKGS[*]} failed..exiting..."
  exit 1
fi

echo
echo "Cloning from github.com/ashayh/dotfiles.git..."
( cd ~ ; git clone https://github.com/ashayh/dotfiles.git ; )

echo
if [[ $? -eq 0 ]] ; then
  echo "git clone successful..."
else
  echo "git clone failed..exiting..."
  exit 1
fi

echo
echo "Running ~/dotfiles/create_dotfiles_etc..."
~/dotfiles/create_dotfiles_etc

echo
if [[ $? -eq 0 ]] ; then
  echo "All done."
else
  echo "script exited with errors."
  exit 1
fi

echo "Running zsh:"
zsh
