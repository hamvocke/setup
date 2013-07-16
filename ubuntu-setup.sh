#!/bin/sh

# This is a simple script to set up ubuntu the way I like it.

# add ppas
echo 'Adding PPAs'
sudo add-apt-repository ppa:webupd8team/sublime-text-3
echo 'Done.'

# update & upgrade
echo 'Performing system update'
sudo apt-get update
sudo apt-get upgrade
echo 'Done.'

# install apps from software-repos
echo 'Installing favourite applications'
sudo apt-get install -y vim ubuntu-restricted-extras git-core gimp inkscape nautilus-dropbox sublime-text-3 chromium 
echo 'Done.'

# install more apps
echo 'Installing oh-my-zsh'
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
echo 'Done.'

# checkout git repos  
echo 'Loading personal configuration from github'
git clone https://github.com/hamvocke/dotfiles.git .dotfiles 

echo 'Replacing dotfiles'
mkdir -p .dotfiles_old
cd .dotfiles
for file in "bashrc vimrc vim zshrc"; do
    mv ~./.$file ~/.dotfiles_old
    echo 'Creating symlink to $file'
    ln -s .dotfiles/$file ~/.$file
done
echo 'Done.'
