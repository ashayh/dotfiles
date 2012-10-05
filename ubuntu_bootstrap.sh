if which apt-get &>/dev/null ; then
  :
else
  echo "apt-get is not present, is this debian/ubuntu?"
  echo "exiting..."
  exit 1
fi

PKGS=(git zsh mercurial curl wget vim unzip)

echo
echo "Installing ${PKGS[*]}..."
apt-get install -y ${PKGS[*]}

echo
if [[ $? -eq 0 ]] ; then
  echo "apt-get -y ${PKGS[*]} successful..."
else
  echo "apt-get -y ${PKGS[*]} failed..exiting..."
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
fi
