#!/bin/sh

projectName=$1;
setting=$2;

echo $(python3 "$(dirname $0)/config.py" -p "$projectName" -s "$setting" || echo 'ERROR: Install python3');
