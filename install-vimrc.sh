#!/bin/sh

#back up original first
mv ~/.vimrc ~/vimrc.bak
mv ~/.vim ~/.vim.bak

#remove existed one
rm -rf ~/.vimrc
rm -rf ~/.vim

#copy the new one
cp -f ./vim_dir/vimrc ~/.vimrc
cp -Rf ./vim_dir ~/.vim
#ln -s .vim/gvimrc .gvimrc

# xmledit
cd ~/.vim/bundle/xmledit/ftplugin/
ln -s xml.vim html.vim
ln -s xml.vim xhtml.vim
