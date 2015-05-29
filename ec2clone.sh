#!/bin/bash

# GET PROJNAME FROM SCRIPT ARGS
if [ $# -eq 0 ]; then
  echo "pass the project name at the end of the script, e.g. '~/.scripts/ec2clone.sh my_project_name.git'"
  exit 1
fi

projname=$1
echo ''
echo "Setting up project '$projname'"..
cd ~/Sites

git clone ec2-user@ec2-54-68-80-150.us-west-2.compute.amazonaws.com:/var/git/$projname

exit 1
