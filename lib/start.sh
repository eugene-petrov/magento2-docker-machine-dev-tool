#!/bin/sh

projectName=$1
build=$2

docker-machine start "${projectName}"
rootDirectory=$($(dirname $0)/config-reader/config.sh "$projectName" 'root_directory')

if [ ! -f "${rootDirectory}/docker" ]; then
    echo "Or use: \"m2dmt create $projectName\""
    exit;
fi

cd "${rootDirectory}/docker"
eval $(docker-machine env "${projectName}")
if [ "build" == "${build}" ]
then
  docker-compose up -d --build;
else
  docker-compose up -d;
fi

docker-machine ssh "${projectName}" "echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p | sudo sysctl -w vm.max_map_count=262144";
