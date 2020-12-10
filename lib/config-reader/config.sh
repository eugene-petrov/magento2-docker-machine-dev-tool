#!/bin/sh

projectName=$1;
setting=$2;

echo $(python3 "./lib/config-reader/config.py" -p "$projectName" -s "$setting" || echo 'ERROR: Install python3');
