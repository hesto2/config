#!/bin/bash
echo starting publish
npx npm-cli-login
cp ~/.npmrc ~/project/.npmrc
cd ~/project
npm publish