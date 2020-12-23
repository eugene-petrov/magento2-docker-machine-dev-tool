#!/bin/sh

command=$1;
projectName=$2

if [ "${command}" == 'create' ]; then
    echo 'NOTE: building process is starting...';
    $(dirname $0)/lib/create/create.sh "$projectName";
    exit;
fi

if [ "${command}" == 'start' ]; then
    echo 'NOTE: starting...';
    $(dirname $0)/lib/start.sh "$projectName";
    exit;
fi

if [ "${command}" == 'stop' ]; then
    $(dirname $0)/lib/stop.sh "$projectName";
    exit;
fi

if [ "${command}" == 'ssh' ]; then
    $(dirname $0)/lib/ssh.sh "$projectName";
    exit;
fi


if [ "${command}" == 'rm' ]; then
    $(dirname $0)/lib/rm.sh "$projectName";
    exit;
fi

echo "Unknown command: ${command}";
