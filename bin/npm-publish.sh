#!/bin/bash
echo starting publish
npx npm-cli-login
cp ~/.npmrc ~/project/.npmrc
cd ~/project
if [ $# -eq 1 ]
  then
    echo "publishing in $1"
    cd $1
fi 
npm publish --access=public