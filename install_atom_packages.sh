#!/usr/bin/env bash

CODE_REPO="$HOME/code"
DOTFILES="$CODE_REPO/dotfiles"

apm_installed=false
while true; do
  printf "Have you installed apm in atom by going to Atom > Install Shell Commands in the menu bar?\n"
  read -p "y/n? " yn
  case $yn in
    [Yy]* ) apm_installed=true
            break;;
    [Nn]* ) break;;
    * ) echo "y/n? ";;
  esac
done

if [ $apm_installed == true ]; then
  install_packages=false
  while true; do
    printf "Do you want to setup atom with some packages?\n"
    read -p "y/n? " yn
    case $yn in
      [Yy]* ) install_packages=true
              break;;
      [Nn]* ) break;;
      * ) echo "y/n? ";;
    esac
  done


  if [ $install_packages == true ]; then
    printf "Setting up Atom prefs\n"
    apm help > ~/atom_installed.txt 2>&1
    apmtest=$(<~/atom_installed.txt)
    [[ $apmtest =~ 'Atom Package Manager' ]] && installed=true || installed=false
    rm ~/atom_installed.txt
    if [ $installed ]; then
      printf "Atom editor is installed\n"
      printf "Installing packages\n"
      apm install adventurous-syntax
      apm install seti-ui
      apm install open-in-browser
      apm install toggle-quotes
      apm install minimap
      apm install linter
      apm install linter-jshint
      apm install dash

      printf "Adding personal config files\n"
      rm -rf "$HOME/.atom/config.cson"
      ln -s "$DOTFILES/config.cson" "$HOME/.atom/config.cson"
      rm -rf "$HOME/.atom/init.coffee"
      ln -s "$DOTFILES/init.coffee" "$HOME/.atom/init.coffee"
      rm -rf "$HOME/.atom/keymap.cson"
      ln -s "$DOTFILES/keymap.cson" "$HOME/.atom/keymap.cson"
      rm -rf "$HOME/.atom/styles.less"
      ln -s "$DOTFILES/styles.less" "$HOME/.atom/styles.less"
      rm -rf "$HOME/.atom/snippets.cson"
      ln -s "$DOTFILES/snippets.cson" "$HOME/.atom/snippets.cson"

      printf "\natom setup complete\n\n*****\n"
    else
      printf "atom editor is not installed"
      printf "install at https://github.com/atom/atom/releases/\n\n*****\n"
    fi
  fi
fi

exit 1
