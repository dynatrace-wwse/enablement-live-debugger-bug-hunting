#!/bin/bash
#loading functions to script
export SECONDS=0
source .devcontainer/util/source_framework.sh

# Validate the Dynatrace credentials declared in devcontainer.json (secrets).
# Codespaces silently omits unset secrets, so without this the container can
# half-create and later DT deploy steps fail with no clear cause. Fail loudly
# instead. The validator logs missing vars by name only (never the values).
variablesNeeded DT_ENVIRONMENT:true DT_OPERATOR_TOKEN:true DT_INGEST_TOKEN:false || exit 1

setUpTerminal

startK3dCluster

installK9s

dynatraceDeployOperator

deployApplicationMonitoring

deployTodoApp

finalizePostCreation

printInfoSection "Your dev container finished creating"
