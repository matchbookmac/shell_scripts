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
cd ~/Sites
mkdir $projname
cd $projname
mkdir js img css js/lib css/lib spec

# README MD
echo ''
echo "downloading template README.md"
curl https://gist.githubusercontent.com/matchbookmac/e246837a98022bd38ed3/raw/f3236243771a998bd77098f77b4d2cdb9adbc282/README.md > ./README.md

# CURL BASE URL
url=http://iancmacdonald.com/scaffolds/js/

echo ''
echo 'downloading scaffolding files'
#Files
curl http://code.jquery.com/jquery-2.1.4.min.js > ./js/lib/jquery.js
# normalize is similar to bootstrap
# curl normalize-css.googlecode.com/svn/trunk/normalize.css > ./css/lib/normalize.css
curl chaijs.com/chai.js > ./spec/chai.js

curl $url/spec/mocha.css > ./spec/mocha.css
curl $url/spec/mocha.js > ./spec/mocha.js
curl $url/spec/specs.js > ./spec/specs.js

curl $url/spec/spec-runner.html > ./spec/spec-runner.html

curl $url/js/scripts.js > ./js/scripts.js
curl $url/css/styles.css > ./css/styles.css
curl $url/sample.html > ./sample.html
curl $url/server.sh > ./server.sh

chmod +x server.sh

mv ./sample.html ./$projname.html

# GIT
echo ''
echo "setting up Git.."
git init .
git config user.name Ian MacDonald
git config user.email ian@iancmacdonald.com
git add .
git commit -m "Initialize files and directories with boiler plate."

echo ''
echo "trying to set up git pair.. (package dependant)"
git pair add im Ian MacDonald

# GIT REMOTE REPO
while true; do
  echo ''
  echo "Create a remote Github repo? ('https://github.com/matchbookmac/$projname')"
  read -p "y/n? " yn
  echo
  case $yn in
    [Yy]* ) curl -u matchbookmac https://api.github.com/user/repos -d '{"name":"'$projname'"}';
            git remote add ian https://github.com/matchbookmac/$projname;
            break;;
    [Nn]* ) break;;
    * ) echo "y/n? ";;
  esac
done

echo ''
here=$(pwd)
echo "$projname set up in: $here"
echo ''

# START PROJECT IN ATOM

atom .

exit 1
