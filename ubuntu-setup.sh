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
sudo apt-get install -y vim ubuntu-restricted-extras git-core gimp inkscape nautilus-dropbox sublime-text-3 chromium xclip keepassx 
echo 'Done.'

# install more apps
echo 'Installing oh-my-zsh'
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
echo 'Done.'

# Configure git
echo 'Configuring git'
git config --global user.name "hamvocke"
git config --global user.email "hermann.vocke@gmail.com"
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

# Configure applications
## terminal -> solarized color scheme
echo 'Configuring gnome terminal'
gconftool-2 --set "/apps/gnome-terminal/profiles/Default/use_theme_background" --type bool false
gconftool-2 --set "/apps/gnome-terminal/profiles/Default/use_theme_colors" --type bool false
gconftool-2 --set "/apps/gnome-terminal/profiles/Default/palette" --type string "#070736364242:#D3D301010202:#858599990000:#B5B589890000:#26268B8BD2D2:#D3D336368282:#2A2AA1A19898:#EEEEE8E8D5D5:#00002B2B3636:#CBCB4B4B1616:#58586E6E7575:#65657B7B8383:#838394949696:#6C6C7171C4C4:#9393A1A1A1A1:#FDFDF6F6E3E3"
gconftool-2 --set "/apps/gnome-terminal/profiles/Default/background_color" --type string "#00002B2B3636"
gconftool-2 --set "/apps/gnome-terminal/profiles/Default/foreground_color" --type string "#65657B7B8383"
echo 'Done.'

# Generate SSH keys
cd ~/.ssh
if [ ! -f id_rsa.pub -o ! -f id_dsa.pub ]; then 
# Checks if keys have already been generated
    echo 'Creating SSH keys'
    ssh-keygen -t rsa -C "hermann.vocke@gmail.com";
else
    echo "SSH keys already exists."
fi
# copy key to clipboard
xclip -sel clip < ~/.ssh/id_rsa.pub
echo 'Done. You can now go and paste them to your github account: https://github.com/settings/ssh'

