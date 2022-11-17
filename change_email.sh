#!/bin/bash

cleanup() {
  echo "Exit..."
  exit
}

trap cleanup INT TERM

echo "Enter the email to put in ~/.gitconfig :"

read -r EMAIL

if [ "$(uname)" == "Darwin" ]
then
  sed -i '' -e "s/CHANGE_EMAIL/${EMAIL/$'\n'}/" "${HOME}/.gitconfig"
else
  sed -i -e "s/CHANGE_EMAIL/${EMAIL/$'\n'}/" "${HOME}/.gitconfig"
fi
