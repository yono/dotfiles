#!/bin/sh

DOTFILES="${HOME}/.dotfiles"

for rcfile in zshrc vimrc hyper.js
do
  ln -sf ${DOTFILES}/${rcfile} ${HOME}/.${rcfile}
done

# brew
for package in `cat brewfiles`
do
  brew install ${package}
done

brew tap homebrew/cask-fonts

for package in `cat brewcaskfiles`
do
  brew cask install ${package}
done

# vim
mkdir -p ${HOME}/.bundle
git clone git://github.com/Shougo/neobundle.vim ${HOME}/.bundle/neobundle.vim
vim -c 'NeoBundleInstall!' -c 'wq' /tmp/tmp.txt
