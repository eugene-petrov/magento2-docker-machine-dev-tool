#!/bin/sh

projectName=$1;

rootDirectory=$(./lib/config-reader/config.sh "$projectName" 'root_directory')

echo 'NOTE: creating structure...'
$(mkdir "$rootDirectory/source")

echo 'NOTE: copying docker files...'
cp -r ./lib/source/docker "$rootDirectory"

echo 'NOTE: creating nginx config...'
envMagentoDirectory="$rootDirectory/docker/env/magento"
serverName=$(./lib/config-reader/config.sh "$projectName" 'nginx.server_name');
cp -r  './lib/source/env/magento' "$envMagentoDirectory"
sed -i "" "s/{server_name}/$serverName/" "$envMagentoDirectory"

nginxConfigPath="$rootDirectory/docker/build/nginx/conf.d/$serverName.conf"
cp "./lib/source/nginx/conf.d/example.conf" "$nginxConfigPath"
sed -i '' "s/{server_name}/$serverName/" "$nginxConfigPath"

echo "NOTE: creating docker-machine $projectName ..."
vmProvider=$(./lib/config-reader/config.sh "$projectName" 'vm.provider');
docker-machine status "$projectName" 2> /dev/null || docker-machine create "$projectName" -d "$vmProvider";

echo 'NOTE: creating the php docker file'
xdebugEnabled=$(./lib/config-reader/config.sh "$projectName" 'php.xdebug_enabled');
envPhpDirectory="$rootDirectory/docker/env/php"
sed -i '' "s/{xdebug_enabled}/$xdebugEnabled/" "$envPhpDirectory"

phpVersion=$(./lib/config-reader/config.sh "$projectName" 'php.version');
phpVersionPrefix="${phpVersion//\./}"
destinationPhpDockerFile="$rootDirectory/docker/build/php/Dockerfile"
cp "./lib/source/php/Dockerfile$phpVersionPrefix" "$destinationPhpDockerFile"
hostIp=$(docker-machine env test | grep DOCKER_HOST | awk -F':' '{print $2}' | awk -F'//' '{print $2}')
sed -i "" "s/{remote_host_ip}/$hostIp/" "$destinationPhpDockerFile"

docker-machine stop "$projectName";
echo 'NOTE: creating completed successfully';
echo 'NOTE: set up your VM, e.g.: share folders, add more RAM and cores, clone files into source folder...';
echo 'NOTE: finish your VM setting and run start command';
