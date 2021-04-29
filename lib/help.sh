#!/bin/sh

Help()
{
   # Display Help
   echo "Magento 2 docker machine dev tool (m2dmt)"
   echo "This is a tool for build, stop and start your docker-machines."
   echo ""
   echo "Example: m2dmt {command} {your-docker-machine-name}"
   echo ""
   echo "Syntax: m2dmt [create|start|stop|ssh|rm]"
   echo "commands:"
   echo "create   Create a new docker-machine"
   echo "start    Start an existing docker-machine (example: m2dmt start {your-docker-machine-name} build)"
   echo "         'build' is optional here. Analog of 'docker-compose up -d --build'"
   echo "stop     Stop an existing docker-machine"
   echo "ssh      Ssh into an existing docker-machine"
   echo "rm       Remove an existing docker-machine"
   echo
}

Help;