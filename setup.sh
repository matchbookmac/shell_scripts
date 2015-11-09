#!/bin/bash

cd ~

if [ $USER != Guest ]; then
  remote=true
else
  remote=false
fi

CODE_REPO="$HOME/code"
DOTFILES="$CODE_REPO/dotfiles"
SETUPFILES="$CODE_REPO/shell_scripts"

printf "\n************\nSetting up dev\n"
mkdir -p $CODE_REPO

function prompt ()
{
  choice=false
  while true; do
    read -p "y/n? " yn
    case $yn in
      [Yy]* ) choice=true
              break;;
      [Nn]* ) break;;
      * ) echo "y/n? ";;
    esac
  done
}

printf "Are you sure you want to append to the existing dotfiles on your sytem?\n"
prompt
link_dotfiles=$choice

if [ $link_dotfiles == true ]; then
  if [ ! -d "$DOTFILES" ]; then
    printf "\n\n*****\n\nSetting up dotfiles\n"
    git clone https://github.com/matchbookmac/dotfiles.git "$DOTFILES"
    #
    printf "bash_profile\n"
    current_bash=$(<~/.bash_profile)
    rm -rf ~/.bash_profile
    ln -s "$DOTFILES/.bash_profile" "$HOME/.bash_profile"
    printf "\n\n# Existing bash_profile before import on $(date)\n\n$current_bash\n" >> ~/.bash_profile
    #
    printf "vimrc\n"
    ln -s "$DOTFILES/.vimrc" "$HOME/.vimrc"
    #
    printf "gitconfig\n"
    ln -s "$DOTFILES/.gitconfig" "$HOME/.gitconfig"
    #
    printf "railsrc\n"
    echo "-d postgresql -T" >> ~/.railsrc
    #
    printf "gemrc\n\n*****\n"
    echo "gem: --no-ri --no-rdoc" >> ~/.gemrc
  else
    printf "$DOTFILES already exists, will not overwrite\n"
  fi
fi

function install_hb ()
{
  printf "Installing homebrew\n"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

function install_jq ()
{
  printf "Installing jq (JSON parsing on command line)\n"
  brew install jq
}

printf "\n*****\n\nDo you want to install atom editor?\n"
prompt
intstall_atom=$choice

if [ $intstall_atom == true ]; then
  printf "Installing atom requires Homebrew and jq, do you wish to install those?\n"
  prompt
  install_hb_jq=$choice
  if [ $install_hb_jq == true ]; then
    install_hb
    install_jq
    printf "Installing atom\n"
    curl https://api.github.com/repos/atom/atom/releases/latest | jq '.assets[] | {name: .name, link: .browser_download_url} | select(.name == "atom-mac.zip").link' | xargs wget -P ~/Downloads
    unzip ~/Downloads/atom-mac.zip -d /Applications/
    rm ~/Downloads/atom-mac.zip
    printf "\n*****\n"
  fi
else
  printf "\n*****\n\nDo you want to install Homebrew?\n"
  prompt
  intstall_homebrew=$choice
  if [ $intstall_homebrew == true ]; then
    install_hb
    printf "\n*****\n\n"
  fi
  #
  printf "\n*****\n\nDo you want to install jq (command line JSON parsing)?\n"
  prompt
  intstall_json=$choice
  if [ $intstall_json == true ]; then
    install_jq
    printf "\n*****\n\n"
  fi
fi

printf "\n*****\n\nDo you want to configure atom with packages from this repo?\n"
prompt
atom_pkg=$choice
if [ $atom_pkg == true ]; then
  rm -rf ~/.atom
  ln -s "$DOTFILES/.atom" "$HOME/.atom"
fi

for i in $SETUPFILES/*.sh; do
  chmod +x $i
done

printf "\nSetup complete\n\n************\n\n"

exit 1
