#!/bin/bash

if which apt-get &>/dev/null ; then
  if apt-cache search mercurial | grep '^mercurial' &>/dev/null ; then
    :
  else
    echo "apt-cache cannot find some packages from your repos."
    echo "Check your /etc/apt/sources.list ?"
    echo "exiting..."
    exit 1
  fi
else
  echo "apt-get is not present, is this debian/ubuntu?"
  echo "exiting..."
  exit 1
fi

PKGS=(curl git grc mercurial source-highlight ruby-dev tmux vim unzip wget zsh tree shellcheck autossh git-extras nmap httpie unrar wireshark build-essential cmake python2.7-dev git-flow inotify-tools)
echo
echo "Installing ${PKGS[*]}..."

if lsof -t /var/lib/dpkg/lock >&/dev/null ; then
  echo "Cannot install packages: Another process has dpkg lock."
  echo "exiting..."
  exit 1
else
  :
fi

echo "Enter passwd for sudo:"
sudo apt-get install -y ${PKGS[*]}

echo
if [[ $? -eq 0 ]] ; then
  echo "apt-get -y install ${PKGS[*]} successful..."
else
  echo "apt-get -y install ${PKGS[*]} failed..exiting..."
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
if [[ $? -eq 0 ]] ; then
  echo "All done."
else
  echo "script exited with errors."
  exit 1
fi

mkdir -p .vim
cd ~/.vim 
test -d .git-radar/.git || git clone https://github.com/michaeldfallen/git-radar .git-radar

cd
if [[ -f ~/.fzf/.git ]] ; then
  :
else
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
fi
cd

echo "@@@@ Installing chruby on ubuntu..."
CHRUBY_VER="0.3.9"
cd /tmp
wget -O chruby-${CHRUBY_VER}.tar.gz https://github.com/postmodern/chruby/archive/v${CHRUBY_VER}.tar.gz
tar -xzvf chruby-${CHRUBY_VER}.tar.gz
cd chruby-${CHRUBY_VER}/
sudo ./scripts/setup.sh

echo "@@@@ Installing ruby-install on ubuntu... this take a LONG time..."
RUBYINSTALL_VER="0.6.0"
cd /tmp
wget -O ruby-install-${RUBYINSTALL_VER}.tar.gz https://github.com/postmodern/ruby-install/archive/v${RUBYINSTALL_VER}.tar.gz
tar -xzvf ruby-install-${RUBYINSTALL_VER}.tar.gz
cd ruby-install-${RUBYINSTALL_VER}/
sudo make install


echo "Running zsh:"
zsh

echo
echo "Running ~/dotfiles/create_dotfiles_etc..."
~/dotfiles/create_dotfiles_etc
