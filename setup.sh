#!/bin/bash

cd ~

if [ $USER != Guest ]
then
  remote=true
else
  remote=false
fi

CODE_REPO="$HOME/code1"
DOTFILES="$CODE_REPO/dotfiles"
SETUPFILES="$CODE_REPO/shell_scripts"

echo ''
echo "Setting up dev"
mkdir -p $CODE_REPO

echo ''
echo "Setting up dotfiles"
git clone https://github.com/matchbookmac/dotfiles.git "$DOTFILES"
echo 'bash_profile'
ln -s "$DOTFILES/.bash_profile" "$HOME/.bash_profile"
echo 'vimrc'
ln -s "$DOTFILES/.vimrc" "$HOME/.vimrc"
echo "railsrc"
echo "-d postgresql -T" >> ~/.railsrc
echo "gemrc"
echo "gem: --no-ri --no-rdoc" >> ~/.gemrc

echo ''
echo 'Install homebrew'
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo ''
echo 'Install jq (JSON parsing on command line)'
brew install jq

echo ''
echo 'Install atom'
curl https://api.github.com/repos/atom/atom/releases/latest | jq '.assets[] | {name: .name, link: .browser_download_url} | select(.name == "atom-mac.zip").link' | xargs wget -P ~/Downloads
unzip ~/Downloads/atom-mac.zip -d ~/Applications/
rm ~/Downloads/atom-mac.zip

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
  apm install adventurous-syntax
  apm install seti-ui
  apm install open-in-browser
  apm install toggle-quotes
  apm install minimap
  apm install linter
  apm install linter-jshint

  echo 'Adding personal config files'
  # curl https://raw.githubusercontent.com/matchbookmac/dotfiles/master/config.cson >> ~/.atom/config.cson
  ln -s "$DOTFILES/config.cson" "$HOME/.atom/config.cson"
  # curl https://raw.githubusercontent.com/matchbookmac/dotfiles/master/init.coffee >> ~/.atom/init.coffee
  ln -s "$DOTFILES/init.coffee" "$HOME/.atom/init.coffee"
  # curl https://raw.githubusercontent.com/matchbookmac/dotfiles/master/keymap.cson >> ~/.atom/keymap.cson
  ln -s "$DOTFILES/keymap.cson" "$HOME/.atom/keymap.cson"
  # curl https://raw.githubusercontent.com/matchbookmac/dotfiles/master/styles.less >> ~/.atom/styles.less
  ln -s "$DOTFILES/styles.less" "$HOME/.atom/styles.less"
  # curl https://raw.githubusercontent.com/matchbookmac/dotfiles/master/snippets.cson >> ~/.atom/snippets.cson
  ln -s "$DOTFILES/snippets.cson" "$HOME/.atom/snippets.cson"

  echo 'atom setup complete'
else
  echo 'atom editor is not installed'
  echo 'install at https://github.com/atom/atom/releases/'
fi


echo ''
echo "Linking scaffolds and scripts"
chmod +x "$SETUPFILES/jsscaffold.sh"
chmod +x "$SETUPFILES/railsscaffold.sh"
chmod +x "$SETUPFILES/sinatra_ruby.sh"
chmod +x "$SETUPFILES/git_create_repo.sh"
chmod +x "$SETUPFILES/ec2clone.sh"

echo ''
echo "Setup complete"
echo ''

exit 1
