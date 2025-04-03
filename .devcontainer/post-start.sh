#!/bin/bash

source /workspaces/enablement-live-debugger-bug-hunting/.devcontainer/util/functions.sh

exposeMkdocs

# Wait for todo to be available
waitForAllPods todoapp

exposeTodoApp

printInfoSection "Your dev.container finished creating"