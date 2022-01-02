#!/bin/bash
echo starting publish
echo //registry.npmjs.org/:_authToken=$NPM_TOKEN >> ~/.npmrc
cp ~/.npmrc ~/project/.npmrc
cd ~/project
if [ $# -eq 1 ]
  then
    echo "publishing in $1"
    cd $1
fi 
npm publish --access=public