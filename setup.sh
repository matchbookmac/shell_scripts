#!/bin/bash

cd ~

echo ''
echo "Setting up vimrc"
curl https://raw.githubusercontent.com/matchbookmac/dotfiles/master/.vimrc >> ~/.vimrc

echo ''
echo "Setting up bash_profile"
curl https://raw.githubusercontent.com/matchbookmac/dotfiles/master/.bash_profile >> ~/.bash_profile
source ~/.bash_profile

echo ''
echo "Pulling down scaffolds and scripts"

git clone https://github.com/matchbookmac/shell_scripts.git
mv ~/shell_scripts ~/.scripts
cd ~/.scripts
rm -rf .git
chmod +x jsscaffold.sh
chmod +x sinatra_ruby.sh

echo ''
echo "Setup complete"
echo ''

exit 1
