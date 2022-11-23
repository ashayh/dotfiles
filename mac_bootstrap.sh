#!/bin/bash
set -u

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

gem install pygments.rb --user-install

brew tap gbataille/homebrew-gba
PKGS=(curl git grc source-highlight tmux wget jq hub gnu-sed cheat awscli autossh packer grc vimpager git-extras nmap httpie ipcalc rar wireshark tree ssh-copy-id awscli ag fzf shellcheck yank cig fpp ghi gist git-open hr osxutils speedtest-cli htop cmake luarocks pkg-config neovim githud ripgrep bpytop hacker1024/hacker1024/coretemp procs jesseduffield/lazygit/lazygit)
echo
echo "Installing ${PKGS[*]}..."

brew install -y ${PKGS[*]}

if [[ $? -eq 0 ]] ; then
  echo "brew install ${PKGS[*]} successful..."
else
  echo "brew install ${PKGS[*]} failed..exiting..."
  exit 1
fi
brew install homebrew/binary/ngrok2

echo
echo "Cloning from github.com/ashayh/dotfiles.git..."
( cd ~ ; git clone https://github.com/ashayh/dotfiles.git ; )

if [[ $? -eq 0 ]] ; then
  echo "git clone successful..."
else
  echo "git clone failed..exiting..."
  exit 1
fi

echo
echo "Running ~/dotfiles/create_dotfiles_etc..."
~/dotfiles/create_dotfiles_etc

if [[ $? -eq 0 ]] ; then
  echo "All done."
else
  echo "script exited with errors."
  exit 1
fi

echo "Running zsh:"
zsh

brew cask install fluor
