#!/bin/sh

projectName=$1

docker-machine start "${projectName}"
rootDirectory=$($(dirname $0)/config-reader/config.sh "$projectName" 'root_directory')
cd "${rootDirectory}/docker"
eval $(docker-machine env "${projectName}")
docker-compose up -d;
docker-machine ssh "${projectName}" "echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p;";
