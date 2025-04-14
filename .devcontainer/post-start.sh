#!/bin/bash

#load the functions into the shell
source /workspaces/$RepositoryName/.devcontainer/util/functions.sh

#This is for professors
#exposeMkdocs

# Wait for todo to be available
waitForAllReadyPods todoapp

exposeTodoApp

printInfoSection "Your dev.container finished creating"