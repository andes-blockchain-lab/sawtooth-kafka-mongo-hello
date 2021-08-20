#!/bin/bash

gnome-terminal --tab -- bash -c "cd ./docker-compose-dev; ./down.sh; ./up.sh; bash"

sleep 10
gnome-terminal --tab -- bash -c "cd ./tp1; npm start; bash"
gnome-terminal --tab -- bash -c "cd ./app; node ./sawtooth-sub-events.js; bash"

sleep 1
gnome-terminal --tab -- bash -c "cd ./app; 
  echo \"Run the following scripts to test that everything is working:\";
  echo \"--sawtooth--\";
  echo \"node ./sawtooth-post.js;\" 
  echo \"node ./sawtooth-get.js;\" 
  echo \"--mongo--\";
  echo \"node ./mongo-sample.js;\"
  echo \"--postgresql--\";
  echo \"node ./postgresql.js;\"
  echo \"--kafka--\";
  echo \"node ./kafka.js;\"
  echo \"---------------\"
  echo \"mongo-express, sawtooth-explorer, pgadmin\"
  echo \"http://localhost:8081 http://localhost:8091 http://localhost:8008/blocks http://localhost:9095\"

  bash"

# firefox http://localhost:8081 http://localhost:8091 http://localhost:8008/blocks http://localhost:9095 &