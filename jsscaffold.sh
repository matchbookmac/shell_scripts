#!/bin/bash

# GET PROJNAME FROM SCRIPT ARGS
if [ $# -eq 0 ]; then
  echo "pass the project name at the end of the script, e.g. '~/.scripts/jsscaffold.sh my_project_name'"
  exit 1
fi

# FOLDER STRUCTURE
projname=$1
echo ''
echo "Setting up project '$projname'"..
if [ $USER != Guest ]
then
  cd ~/Sites
else
  cd ~/Desktop
fi
mkdir $projname
cd $projname
mkdir js img css js/lib css/lib spec

# README MD
echo ''
echo "downloading template README.md"
curl https://gist.githubusercontent.com/matchbookmac/e246837a98022bd38ed3/raw/f3236243771a998bd77098f77b4d2cdb9adbc282/README.md > ./README.md

# CURL BASE URL
url=http://iancmacdonald.com/scaffolds/js

echo ''
echo 'downloading scaffolding files'
#Files
echo 'jQuery'
curl http://code.jquery.com/jquery-2.1.4.min.js > ./js/lib/jquery.js
# normalize is similar to bootstrap
# curl normalize-css.googlecode.com/svn/trunk/normalize.css > ./css/lib/normalize.css
echo 'chai and mocha'
curl chaijs.com/chai.js > ./spec/chai.js

curl https://raw.githubusercontent.com/mochajs/mocha/master/mocha.css > ./spec/mocha.css
curl https://raw.githubusercontent.com/mochajs/mocha/master/mocha.js > ./spec/mocha.js

# Use below if mocha above doesn't download
# curl $jsurl/spec/mocha.js > ./spec/mocha.js
# curl $jsurl/spec/mocha.css > ./spec/mocha.csscurl
echo 'js specs'
curl $url/spec/specs.js > ./spec/specs.js

curl $url/spec/spec-runner.html > ./spec/spec-runner.html

echo 'scripts, styles, and config'
curl $url/js/scripts.js > ./js/scripts.js
curl $url/css/styles.css > ./css/styles.css
curl $url/sample.html > ./sample.html
curl $url/server.sh > ./server.sh

chmod +x server.sh

mv ./sample.html ./$projname.html

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

if [ $pairing_today == true ]
then
  echo ''
  echo "trying to set up git pair.. (package dependant)"
  git pair add im Ian MacDonald
  git pair add $pair_init $pair_first_name $pair_last_name
  git pair im $pair_init
else
  git config user.name Ian MacDonald
  git config user.email ian@iancmacdonald.com
fi

git commit -m "Initialize files and directories with boiler plate."

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

echo ''
here=$(pwd)
echo "$projname set up in: $here"
echo ''


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

# OPEN TEST WEBPAGES
open $projname.html
open spec/spec-runner.html

exit 1
