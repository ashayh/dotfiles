#!/bin/bash

# Fix vim-puppet to not load syntastic as it screws powerline colors:
sed  -i -e '/^syn /d' ~/.vim/vim-addons/github-rodjek-vim-puppet/ftplugin/puppet.vim
