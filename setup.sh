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
echo "Setting up Atom prefs"
apm help > test 2>&1
apmtest=$(<~/test)
[[ $apmtest =~ 'Atom Package Manager' ]] && installed=true || installed=false
rm ~/test
if [$installed]
then
  echo 'atom editor is installed'
  apm install seti-syntax
  apm install seti-ui
  apm install open-in-browser
  apm install toggle-quotes
  echo 'atom setup complete'
else
  echo 'atom editor is not installed'
  echo 'install at https://github.com/atom/atom/releases/'
fi


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
