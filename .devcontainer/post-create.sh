#!/bin/bash
#loading functions to script
export SECONDS=0
source .devcontainer/util/source_framework.sh

setUpTerminal

startKindCluster

installK9s

dynatraceDeployOperator

deployCloudNative

deployTodoApp

finalizePostCreation

#workaround for instruqt
printInfo "trusting directory for instruqt since running on root"
git config --global --add safe.directory '*'

printInfoSection "Your dev container finished creating"
