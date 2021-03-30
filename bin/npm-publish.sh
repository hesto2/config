#!/bin/bash
echo starting publish
npx npm-cli-login
cp ~/.npmrc ~/project/.npmrc
cd ~/project
pwd
cd $1
npm publish --access=public