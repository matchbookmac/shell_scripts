#!/bin/bash

# GET PROJNAME FROM SCRIPT ARGS
if [ $# -eq 0 ]; then
  echo "pass the project name at the end of the script, e.g. '~/.scripts/sinatra_ruby.sh my_project_name'"
  exit 1
fi

# FOLDER STRUCTURE
projname=$1
echo ''
echo "Setting up project '$projname'"..
cd ~/Sites
mkdir $projname
cd $projname
mkdir config db lib public public/css public/img public/js spec views

# README MD
echo ''
echo "downloading template README.md"
curl https://gist.githubusercontent.com/matchbookmac/e246837a98022bd38ed3/raw/28501527efe0b197b7cdf6c604a31b32a1762b0c/rubyREADME.md > ./README.md

# CURL BASE URL
url=http://iancmacdonald.com/scaffolds/sinatra_ruby/
jsurl=http://iancmacdonald.com/scaffolds/js/

echo ''
echo 'downloading scaffolding files'
#Files
curl http://code.jquery.com/jquery-2.1.4.min.js > ./public/js/jquery.js
# normalize is similar to bootstrap
# curl normalize-css.googlecode.com/svn/trunk/normalize.css > ./css/lib/normalize.css

curl chaijs.com/chai.js > ./spec/chai.js
curl $jsurl/spec/mocha.css > ./spec/mocha.css
curl $jsurl/spec/mocha.js > ./spec/mocha.js
curl $jsurl/spec/specs.js > ./spec/specs.js
curl $jsurl/spec/spec-runner.html > ./spec/spec-runner.html
curl $jsurl/js/scripts.js > ./js/scripts.js

curl $jsurl/server.sh > ./server.sh

curl $url/config/database.yml > ./config/database.yml

curl $url/public/css/styles.css > ./public/css/styles.css

curl $url/lib/test.rb > ./lib/test.rb
curl $url/spec/test_spec.rb > ./spec/test_spec.rb
curl $url/spec/spec_helper.rb > ./spec/spec_helper.rb
curl $url/spec/integration_spec.rb > ./spec/integration_spec.rb

curl $url/views/index.erb > ./views/index.erb
curl $url/views/layout.erb > ./views/layout.erb
curl $url/views/test.erb > ./views/test.erb

curl $url/app.rb > ./app.rb
curl $url/config.ru > ./config.ru
curl $url/Gemfile > ./Gemfile
curl $url/Rakefile > ./Rakefile

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
