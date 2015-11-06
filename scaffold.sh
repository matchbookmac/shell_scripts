#!/bin/bash

# GET PROJNAME FROM SCRIPT ARGS
if [ $# -eq 0 ]; then
  echo "pass the project name at the end of the script, e.g. './scaffold.sh my_project_name'"
  exit 1
fi

# FOLDER STRUCTURE
projname=$1
echo ''
echo "Setting up project '$projname'"..
cd ~/Desktop
mkdir $projname
cd $projname
mkdir js img css js/lib css/lib spec

# README MD
echo ''
echo "downloading template README.md"
curl http://epicodus.drews.space/READMEs/epicodus_basic_unlicense/README.md > ./README.md

# CURL BASE URL
url=http://epicodus.drews.space/scaffolding/jquery

echo ''
echo 'downloading scaffolding files'
#Files
curl http://code.jquery.com/jquery-1.11.3.js > ./js/lib/jquery-1.11.3.js
curl normalize-css.googlecode.com/svn/trunk/normalize.css > ./css/lib/normalize.css
curl chaijs.com/chai.js > ./spec/chai.js

curl $url/spec/mocha.css > ./spec/mocha.css
curl $url/spec/mocha.js > ./spec/mocha.js
curl $url/spec/specs.js > ./spec/specs.js

curl $url/spec/spec-runner.html > ./spec/spec-runner.html

curl $url/js/script.js > ./js/script.js
curl $url/css/style.css > ./css/style.css
curl $url/sample.html > ./sample.html
curl $url/server.sh > ./server.sh

chmod +x server.sh

# GIT
echo ''
echo "setting up Git.."
git init .
git config user.name Drew Finstrom
git config user.email drew@finstrom.us
git add .

echo ''
echo "trying to set up git pair.. (package dependant)"
git pair add dgf Drew

# GIT REMOTE REPO
while true; do
  echo ''
  echo "Create a remote Github repo? ('https://github.com/dgf1979/epicodus-$projname')"
  read -p "y/n?" yn
  echo
  case $yn in
    [Yy]* ) curl -u dgf1979 https://api.github.com/user/repos -d '{"name":"epicodus-'$projname'"}';
            git remote add drew https://github.com/dgf1979/epicodus-$projname;
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
