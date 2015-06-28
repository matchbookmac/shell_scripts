#!/bin/bash

# FOLDER STRUCTURE
projname=${PWD##*/}
echo ''
echo "Setting up project '$projname' in git"..
if [ $USER != Guest ]
then
  cd ~/Sites
else
  cd ~/Desktop
fi

cd $projname
url=http://iancmacdonald.com/scaffolds/rails/

# README MD
echo ''
echo "downloading template README.md"
mv ./README.rdoc ./README.md
curl https://gist.githubusercontent.com/matchbookmac/e246837a98022bd38ed3/raw/95607f6d9463675ef64648b83998433704a5313f/railsREADME.md > ./README.md

echo ''
echo "Adding Gemfile"
curl $url/Gemfile > ./Gemfile

echo ''
echo "Bundling"
env ARCHFLAGS='-arch x86_64' bundle install

echo ''
echo "Using RSpec"
rails generate rspec:install

# PAIRING
pairing_today=false
while true; do
  echo ''
  echo "Are you pairing today?"
  read -p "y/n? " yn
  echo
  case $yn in
    [Yy]* ) pairing_today=true
            read -p "Pair first name: " pair_first_name
            read -p "Pair last name: " pair_last_name
            read -p "Pair initials: " pair_init
            read -p "Pair Github Username: " pair_user
            pair_name=$pair_first_name\ $pair_last_name
            break;;
    [Nn]* ) break;;
    * ) echo "y/n? ";;
  esac
done

# GIT AND PAIRING
echo ''
echo "setting up Git.."
git init .
git add .
git config user.name Ian MacDonald
git config user.email ian@iancmacdonald.com

if [ $pairing_today == true ]
then
  echo ''
  echo "trying to set up git pair.. (package dependant)"
  git pair add im Ian MacDonald
  git pair add $pair_init $pair_first_name $pair_last_name
  git pair im $pair_init
fi

git commit -m "Initialize Rails project."

# GIT REMOTE REPO
while true; do
  echo ''
  echo "Create a remote Github repo? ('https://github.com/matchbookmac/$projname')"
  read -p "y/n? " yn
  echo
  case $yn in
    [Yy]* ) curl -u matchbookmac https://api.github.com/user/repos -d '{"name":"'$projname'"}'
            git remote add ian https://github.com/matchbookmac/$projname
            if [ $pairing_today == true ]; then
              curl -u $pair_user https://api.github.com/user/repos -d '{"name":"'$projname'"}'
              git remote add $pair_first_name https://github.com/$pair_user/$projname
            fi
            break;;
    [Nn]* ) break;;
    * ) echo "y/n? ";;
  esac
done

# START PROJECT IN ATOM AND BROWSER
while true; do
  echo ''
  echo "Start project in Atom?"
  read -p "y/n? " yn
  echo
  case $yn in
    [Yy]* )
      atom .
      break;;
    [Nn]* )
      break;;
    * )
      echo "y/n? ";;
  esac
done

# OPEN APP
open http://localhost:3000

exit 1
