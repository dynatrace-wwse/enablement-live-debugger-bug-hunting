#!/bin/bash

source /workspacese/$RepositoryName/.devcontainer/util/functions.sh

#This is for professors
#exposeMkdocs

# Wait for todo to be available
waitForAllPods todoapp

exposeTodoApp

printInfoSection "Your dev.container finished creating"