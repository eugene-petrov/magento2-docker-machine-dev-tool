#!/bin/sh

command=$1;
projectName=$2

if [ "${command}" == 'create' ]; then
    echo 'NOTE: building process is starting...';
    ./lib/create/create.sh "$projectName";
    exit;
fi

if [ "${command}" == 'start' ]; then
    echo 'NOTE: starting...';
    ./lib/start.sh "$projectName";
    exit;
fi

if [ "${command}" == 'stop' ]; then
    ./lib/stop.sh "$projectName";
    exit;
fi

if [ "${command}" == 'ssh' ]; then
    ./lib/ssh.sh "$projectName";
    exit;
fi


if [ "${command}" == 'rm' ]; then
    ./lib/rm.sh "$projectName";
    exit;
fi

echo "Unknown command: ${command}";
