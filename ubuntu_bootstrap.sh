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

PKGS=(curl git grc mercurial source-highlight tmux vim unzip wget zsh)
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
