#!/bin/bash

# Fix vim-puppet to not load syntastic as it screws powerline colors:
# sed  -i -e '/^syn /d' ~/.vim/vim-addons/github-rodjek-vim-puppet/ftplugin/puppet.vim

if [[ -d /usr/share/puppet/ext/vim ]] ; then
  echo "puppet vim plugins can becopied to ~/.vim"
  echo "copying"
  cp -a /usr/share/puppet/ext/vim/*/ ${HOME}/.vim/
fi
