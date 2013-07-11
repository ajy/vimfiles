#!/bin/sh
#backup old config
cp -r ~/.vim ~/.vim.old 2>/dev/null
rm -fr ~/.vim 2>/dev/null
cp ~/.vimrc ~/.vimrc_backup 2>/dev/null
rm -f ~/.vimrc 2>/dev/null

#retrieve my files, and setup it up
git clone https://github.com/ajy/vimfiles ~/.vim && cd ~/.vim && ln -s ~/.vim/vimrc ~/.vimrc

#create backup and swap directory
mkdir ~/.cache/vim

# get vundle first
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

#get tagbar
sudo apt-get install exuberant-ctags

# now install plugins into vim
vim +BundleInstall
