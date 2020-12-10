#!/bin/sh

projectName=$1

docker-machine stop "${projectName}"
