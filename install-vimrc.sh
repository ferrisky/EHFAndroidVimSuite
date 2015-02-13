#!/bin/sh

#back up original first
rm -rf  ~/vimrc.bak
rm -rf ~/.vim.bak
mv ~/.vimrc ~/vimrc.bak
mv ~/.vim ~/.vim.bak

#remove existed one
rm -rf ~/.vimrc
rm -rf ~/.vim
rm -rf /tmp/PowerLine.cache
#copy the new one
cp -f ./vim_dir/vimrc ~/.vimrc
cp -Rf ./vim_dir ~/.vim
#ln -s .vim/gvimrc .gvimrc

# xmledit
cd ~/.vim/bundle/xmledit/ftplugin/
ln -s xml.vim html.vim
ln -s xml.vim xhtml.vim
