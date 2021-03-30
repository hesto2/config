#!/bin/bash
echo starting publish
npx npm-cli-login
cp ~/.npmrc ~/project/.npmrc
cd ~/project
if [ $# -eq 1 ]
  then
    echo test
    cd $1
fi 
npm publish --access=public