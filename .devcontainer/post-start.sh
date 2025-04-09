#!/bin/bash

source /workspacese$RepositoryName/.devcontainer/util/functions.sh

#exposeMkdocs

# Wait for todo to be available
waitForAllPods todoapp

exposeTodoApp

printInfoSection "Your dev.container finished creating"