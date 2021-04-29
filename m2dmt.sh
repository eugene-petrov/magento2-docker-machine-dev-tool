#!/bin/sh

command=$1;
projectName=$2;
build=$3;

FILE=$(dirname $0)/lib/"${command}".sh
if [ -f "$FILE" ]; then
    "$FILE" "$projectName" "$build" || echo 'catch'
else
    $(dirname $0)/lib/help.sh
fi
