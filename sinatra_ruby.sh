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
if [ $USER != Guest ]
then
  cd ~/Sites
else
  cd ~/Desktop
fi
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
echo 'jQuery'
curl http://code.jquery.com/jquery-2.1.4.min.js > ./public/js/jquery.js
# normalize is similar to bootstrap
# curl normalize-css.googlecode.com/svn/trunk/normalize.css > ./css/lib/normalize.css

echo 'chai and mocha'
curl chaijs.com/chai.js > ./spec/chai.js
curl https://raw.githubusercontent.com/mochajs/mocha/master/mocha.css > ./spec/mocha.css
curl https://raw.githubusercontent.com/mochajs/mocha/master/mocha.js > ./spec/mocha.js

# Use below if mocha above doesn't download
# curl $jsurl/spec/mocha.js > ./spec/mocha.js
# curl $jsurl/spec/mocha.css > ./spec/mocha.css

echo 'js specs'
curl $jsurl/spec/specs.js > ./spec/specs.js
curl $url/spec/spec-runner.html > ./spec/spec-runner.html

echo 'js'
curl $jsurl/js/scripts.js > ./public/js/scripts.js

echo 'config'
curl $jsurl/server.sh > ./server.sh

curl $url/config/database.yml > ./config/database.yml

echo 'styles'
curl $url/public/css/styles.css > ./public/css/styles.css

echo 'ruby specs'
curl $url/lib/test.rb > ./lib/test.rb
curl $url/spec/test_spec.rb > ./spec/test_spec.rb
curl $url/spec/spec_helper.rb > ./spec/spec_helper.rb
curl $url/spec/integration_spec.rb > ./spec/integration_spec.rb

echo 'views'
curl $url/views/index.erb > ./views/index.erb
curl $url/views/layout.erb > ./views/layout.erb
curl $url/views/test.erb > ./views/test.erb

echo 'app'
curl $url/app.rb > ./app.rb
curl $url/config.ru > ./config.ru
curl $url/Gemfile > ./Gemfile
curl $url/Rakefile > ./Rakefile

chmod +x server.sh

# INSTALL GEMS
bundle install

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

# RUN TESTS
rspec

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

# OPEN JS TEST WEBPAGE
open spec/spec-runner.html

while true; do
  echo ''
  echo "Start Sinatra server?"
  read -p "y/n? " yn
  echo
  case $yn in
    [Yy]* )
      open http://localhost:4567/
      ruby app.rb
      break;;
    [Nn]* )
      break;;
    * )
      echo "y/n? ";;
  esac
done


exit 1
