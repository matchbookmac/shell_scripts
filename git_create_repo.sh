#!/bin/bash

# GET PROJNAME FROM SCRIPT ARGS
if [ $# -eq 0 ]; then
  echo "pass the project name at the end of the script, e.g. '~/.scripts/git_create_repo.sh [project_name]'"
  exit 1
fi

projname=$1

# GIT REMOTE REPO
while true; do
  echo ''
  echo "Create a remote Github repo? ('https://github.com/matchbookmac/$projname')"
  read -p "y/n? " yn
  echo
  case $yn in
    [Yy]* ) curl -u matchbookmac https://api.github.com/user/repos -d '{"name":"'$projname'"}'
            git remote add ian https://github.com/matchbookmac/$projname
            break;;
    [Nn]* ) break;;
    * ) echo "y/n? ";;
  esac
done

#TODO separate out adding remote and adding repo.

exit 1
