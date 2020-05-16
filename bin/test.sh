echo "React project? y/n"
read reactValue

if [ $reactValue == 'y' ]
then
  # Config for a react app
  echo 1
else
  # Config for a node app
  echo 2
fi


echo "Done 🎉🎉"
