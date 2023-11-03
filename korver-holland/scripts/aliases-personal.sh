#!/bin/bash

# PLEASE ADD BELOW TO YOUR .bashrc
# REPLACE {PATH_TO_DEVILBOX} WITH YOUR PATH TO DEVILBOX
# FOR WINDOWS
# if [ -f {PATH_TO_DEVILBOX}/korver-holland/scripts/aliases-personal.sh ]; then
#     . {PATH_TO_DEVILBOX}/korver-holland/scripts/aliases-personal.sh
# fi
#
#
#


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

alias dvl-up="docker compose \
  -f $DIR/../../docker-compose.yml \
  -f $DIR/../../docker-compose.kh.yml \
  --project-directory=$DIR/../../ up -d php php71 php74 mysql httpd bind elastic mailhog redis"

alias dvl-down="docker compose -f $DIR/../../docker-compose.yml -f $DIR/../../docker-compose.kh.yml --project-directory=$DIR/../../ down" 
alias dvl-start="docker compose -f $DIR/../../docker-compose.yml -f $DIR/../../docker-compose.kh.yml --project-directory=$DIR/../../ start -d php php71 php74 mysql httpd bind elastic mailhog redis"
alias dvl-stop="docker compose -f $DIR/../../docker-compose.yml -f $DIR/../../docker-compose.kh.yml --project-directory=$DIR/../../ stop"
alias dvl-restart="dvl-down && dvl-up"

