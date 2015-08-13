#!/bin/bash

cd ~

if [ $USER != Guest ]
then
  remote=true
else
  remote=false

fi

echo ''
echo "Setting up vimrc"
curl https://raw.githubusercontent.com/matchbookmac/dotfiles/master/.vimrc >> ~/.vimrc

echo ''
echo "Setting up bash_profile"
curl https://raw.githubusercontent.com/matchbookmac/dotfiles/master/.bash_profile >> ~/.bash_profile
source ~/.bash_profile

echo ''
echo "Setting up Chrome"
curl https://raw.githubusercontent.com/matchbookmac/shell_scripts/master/Bookmarks >> ~/Library/Application\ Support/Google/Chrome/Default/Bookmarks
curl https://github.com/matchbookmac/shell_scripts/blob/master/Preferences > ~/Library/Application\ Support/Google/Chrome/Default/Preferences

echo ''
echo "Setting up rails"
echo "-d postgresql -T" >> ~/.railsrc

echo ''
echo "Setting up gem install"
echo "gem: --no-ri --no-rdoc" >> ~/.gemrc

echo ''
echo "Setting up Atom prefs"
apm help > ~/test 2>&1
apmtest=$(<~/test)
[[ $apmtest =~ 'Atom Package Manager' ]] && installed=true || installed=false
rm ~/test
if [ $installed ]
then
  echo 'Atom editor is installed'
  echo 'Installing packages'
  apm install seti-syntax
  apm install seti-ui
  apm install open-in-browser
  apm install toggle-quotes
  apm install linter
  apm install linter-jshint

  echo 'Adding personal config files'
  curl https://raw.githubusercontent.com/matchbookmac/dotfiles/master/config.cson >> ~/.atom/config.cson
  curl https://raw.githubusercontent.com/matchbookmac/dotfiles/master/init.coffee >> ~/.atom/init.coffee
  curl https://raw.githubusercontent.com/matchbookmac/dotfiles/master/keymap.cson >> ~/.atom/keymap.cson
  curl https://raw.githubusercontent.com/matchbookmac/dotfiles/master/styles.less >> ~/.atom/styles.less
  curl https://raw.githubusercontent.com/matchbookmac/dotfiles/master/snippets.cson >> ~/.atom/snippets.cson

  echo 'atom setup complete'
else
  echo 'atom editor is not installed'
  echo 'install at https://github.com/atom/atom/releases/'
fi


echo ''
echo "Pulling down scaffolds and scripts"

git clone https://github.com/matchbookmac/shell_scripts.git ~/.scripts
cd ~/.scripts
rm -rf .git
chmod +x jsscaffold.sh
chmod +x railsscaffold.sh
chmod +x sinatra_ruby.sh
chmod +x git_create_repo.sh
chmod +x ec2clone.sh

echo ''
echo "Setup complete"
echo ''

exit 1
