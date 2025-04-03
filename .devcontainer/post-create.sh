#!/bin/bash

# Install RunMe
# RunMe makes markdown files runnable
# Used during end2end testing to execute the code snippets
source /workspaces/enablement-live-debugger-bug-hunting/.devcontainer/util/functions.sh

bindFunctionsInShell

setupAliases

installRunme

#buildLabGuide
#exposeLabguide

createKindCluster

installK9s

installMkdocs

dynatraceEvalReadSaveCredentials

dynatraceDeployOperator

waitForAllPods dynatrace

deployTodoApp


# e2e testing
# If the codespace is created (eg. via a Dynatrace workflow)
# and hardcoded to have a name starting with dttest-
# Then run the e2e test harness
# Otherwise, send the startup ping
if [[ "$CODESPACE_NAME" == dttest-* ]]; then
    # Set default repository for gh CLI
    gh repo set-default "$GITHUB_REPOSITORY"

    # Set up a label, used if / when the e2e test fails
    # This may already be set, so catch error and always return true
    gh label create "e2e test failed" --force || true

    # Install required Python packages
    pip install -r "/workspaces/$REPOSITORY_NAME/.devcontainer/testing/requirements.txt" --break-system-packages

    # Run the test harness script
    python "/workspaces/$REPOSITORY_NAME/.devcontainer/testing/testharness.py"

    # Testing finished. Destroy the codespace
    gh codespace delete --codespace "$CODESPACE_NAME" --force
else

    # Your content here
    printWarn "TODO: Uncomment postCodespaceTracker before goLive - Sending BizEvent to track usage of enablement-live-debugger-bug-hunting"
    # Uncomment below
    #postCodespaceTracker enablement-live-debugger-bug-hunting
    printInfo "Finished creating"
fi