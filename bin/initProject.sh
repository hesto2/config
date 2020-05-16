MODULE_DIR=./node_modules/@hesto2/config

echo "Circle CI (1) or Travis (2):"
read ciValue

echo "React project? y/n"
read reactValue

git init
cp $MODULE_DIR/.gitignore ./

if [ $reactValue == 'y' ]; then
  # Config for a react app
  npx create-react-app . --template typescript
  yarn add use-state-api-hooks @material-ui/core @material-ui/styles @material-ui/icons clsx
  yarn add -D @hesto2/config
  echo "{}" >tsconfig.json
  npx json -I -f tsconfig.json -e 'this.extends = "./node_modules/@hesto2/config/tsconfig.react.json"'
  npx json -I -f package.json -e 'this.eslintConfig = undefined'
else
  # Config for a node app
  yarn init -y
  echo "{}" >tsconfig.json
  yarn add -D nodemon typescript ts-node jest ts-jest cross-env @hesto2/config
  npx json -I -f tsconfig.json -e 'this.extends = "./node_modules/@hesto2/config/tsconfig.json"'
  npx json -I -f tsconfig.json -e 'this.include = [
    "src/**/*"
  ]'
  npx json -I -f tsconfig.json -e 'this.outDir = "./dist"'
  npx json -I -f package.json -e 'this.scripts = {"watch": "yarn cross-env NODE-ENV=development nodemon -e ts --exec ts-node ./src/index.ts",
   "test": "jest ./src",
    "prebuild": "rm -rf ./dist"
    "build": "tsc && cp package.json ./dist && cd ./dist && yarn install --prod && cd ../"
    }'
  echo "module.exports = {...require(@hesto2/config/jest.config.js)}" >jest.config.js

  mkdir terraform
  mkdir src
  mkdir dist
  cd terraform && yarn init -y && cp ../.gitignore ./ && yarn add -D hesto2-terraform-modules
  cd ../
fi

echo "module.exports = {...require(@hesto2/config/.eslintrc.js)}" >.eslintrc.js

yarn add prettier pretty-quick husky eslint -D
echo "module.exports = {...require(@hesto2/config/prettier.config.js)}" >prettier.config.js

npx json -I -f package.json -e 'this.husky={ "hooks": { "pre-commit": "pretty-quick --staged" } }'

if [ $ciValue == 1 ]; then
  cp -r $MODULE_DIR/.circleci ./
else
  cp $MODULE_DIR/.travis.yml /
fi

echo "Done 🎉🎉"
