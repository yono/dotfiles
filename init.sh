#!/bin/sh

if !(type "brew" > /dev/null 2>&1); then
  echo "Homebrewをインストールしてください"
  exit
fi

DOTFILES="${HOME}/.dotfiles"

for rcfile in zshrc vimrc
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
  brew install ${package} --cask
done

# vim
mkdir -p ${HOME}/.bundle
git clone git://github.com/Shougo/neobundle.vim ${HOME}/.bundle/neobundle.vim
vim -c 'NeoBundleInstall!' -c 'wq' /tmp/tmp.txt
