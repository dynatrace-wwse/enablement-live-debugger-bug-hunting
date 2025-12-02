#!/bin/bash
# ======================================================================
#          ------- Custom Functions -------                            #
#  Space for adding custom functions so each repo can customize as.    # 
#  needed.                                                             #
# ======================================================================


### Variables
APPLICATION_URL="http://localhost:30100"
IMAGE_NAME="todoapp:local"
NAMESPACE="todoapp"
DEPLOYMENT_NAME="todoapp"


customFunction(){
  printInfoSection "This is a custom function that calculates 1 + 1"

  printInfo "1 + 1 = $(( 1 + 1 ))"

}

redeployApp(){

  printInfoSection "Building local image"

  printInfo "docker build -t $IMAGE_NAME app"

  if ! docker build -t $IMAGE_NAME app; then
    printError "❌ Docker build failed. Stopping deployment, fix the compilation issues..."
    return 1
  else
    printInfo "✅ Docker build succeeded. New image built $IMAGE_NAME"
  fi

  printInfo "Loading image into kind cluster"
  kind load docker-image $IMAGE_NAME

  printInfo "Updating deployment image"
  kubectl set image deployment/$DEPLOYMENT_NAME $DEPLOYMENT_NAME=$IMAGE_NAME -n $NAMESPACE

  printInfo "Restarting deployment to apply changes"
  kubectl rollout restart deployment/$DEPLOYMENT_NAME -n $NAMESPACE

  printInfo "Waiting for rollout to complete"
  kubectl rollout status deployment/$DEPLOYMENT_NAME -n $NAMESPACE

  printInfo "Done"

}


is_bug1_there(){
  
  kubectl logs -l app=todoapp -c todoapp -n todoapp | grep 'completed=true' > /dev/null
  mark_completed=$?
  
  kubectl logs -l app=todoapp -c todoapp -n todoapp | grep 'Failed to delete completed todos' > /dev/null
  click_clear_completed=$?

  if [ $mark_completed -eq 0 ] && [ $click_clear_completed -eq 0 ]; then
    printInfo "🪲 Bug 'Clear completed' is there! Thanks for adding tasks and trying to clear them."
    return 0
  else
    printWarn " ⚠️ Please add a couple of task, mark them completed and then click on the 'clear completed' button in order to see if the 🪲 bug is there..."
    return 1
  fi

}

is_bug1_solved(){

  printInfoSection "Verifying if the 🪲 Bug 'Clear completed' is gone"
  
  addTask '{"title":"Clear completed task","completed":true}'

  clearCompletedTasks

  kubectl logs -l app=todoapp -c todoapp -n todoapp | grep 'Removed Todo record.*completed=true' > /dev/null
  found_removed=$?

  if [ $found_removed -eq 0 ]; then
    printInfo "✅ Bug clear completed is gone."
    return 0
  else
    printWarn "⚠️ Bug clear completed is still there, tip: check the Arrays"
    return 1
  fi

}

is_bug2_solved(){
  printInfoSection "Verifying if the 🪲 Bug 'Special Characters' is gone"
  RC=0

  addTask '{"title":"Exciting validation!?#","completed":false}'

  printInfo "Retrieving todos to verify the title..."
  
  response=$(curl -s -X GET $APPLICATION_URL/todos)

  # Check if special characters are preserved
  if echo "$response" | grep -q '"title":"Exciting validation!?#"'; then
    printInfo "✅ Bug special characters is gone. Title preserved correctly."      
    RC=0
  elif echo "$response" | grep -q '"title":"Exciting validation"'; then
    printWarn "⚠️ Bug special characters is still there. Special characters were stripped from the title. Tip: Less is more ;)"
    RC=1
  fi

  # Delete taskId
  #deleteTask $response  
  return $RC
}

deleteTask(){
  response="$1"
  # might need it later
  task_id=$(echo "$response" | grep -o '"title":"Exciting validation[^"]*","id":"[^"]*"' | grep -o '"id":"[^"]*"' | cut -d'"' -f4)
  if [ -n "$task_id" ]; then
    printInfo "Deleting task ID: $task_id"
    delete_response=$(curl -s -X DELETE $APPLICATION_URL/todos/$task_id)
    if echo "$delete_response" | grep -q '"status":"ok"'; then
      printInfo "Task deleted successfully"
    else
      printInfo "Failed to delete task"
    fi
  fi
}

solve_bug1(){
  
  printInfoSection "Solving the Bug Clear Completed"

  printInfo "we change to the branch solution/bug1 where the developer already added the solution for us"

  printInfo "git checkout solution/bug1"

  git checkout solution/bug1

  printInfo "then we compile the application and redeploy it to the Kubernetes Cluster using the function 'redeployApp'"
  
  redeployApp

  setVersionControl "solution/bug1"

  printInfo "Now add some tasks, mark them completed and click on 'clear completed'"
  printInfo "You can assert that the bug is gone also by typing 'is_bug1_solved'"
}

setVersionControl(){
  printInfo "Setting version control in the DEPLOYMENT_NAME=$DEPLOYMENT_NAME to point to '$1' "
  updateVersionControl "$1" 
  patchDeployment

}


updateVersionControl(){

  version="$1"

  if [ -z "$version" ]; then
    version="v1.0.1"
  fi
  DT_LIVEDEBUGGER_REMOTE_ORIGIN=$(git remote get-url origin)
  DT_LIVEDEBUGGER_COMMIT=$(git rev-parse $version)

  printInfo "Fetching git revision for $version in DT_LIVEDEBUGGER_REMOTE_ORIGIN=$DT_LIVEDEBUGGER_REMOTE_ORIGIN" 
  printInfo "DT_LIVEDEBUGGER_COMMIT=$DT_LIVEDEBUGGER_COMMIT"

  export DT_LIVEDEBUGGER_REMOTE_ORIGIN=$DT_LIVEDEBUGGER_REMOTE_ORIGIN
  export DT_LIVEDEBUGGER_COMMIT=$DT_LIVEDEBUGGER_COMMIT
}

patchDeployment(){ 
kubectl patch deployment $DEPLOYMENT_NAME -n $NAMESPACE -p "$(cat <<EOF
{
    "spec": {
        "template": {
            "spec": {
                "containers": [
                    {
                        "name": "$DEPLOYMENT_NAME",
                        "env": [
                            {
                                "name": "DT_LIVEDEBUGGER_COMMIT",
                                "value": "$DT_LIVEDEBUGGER_COMMIT"
                            },
                            {
                                "name": "DT_LIVEDEBUGGER_REMOTE_ORIGIN",
                                "value": "$DT_LIVEDEBUGGER_REMOTE_ORIGIN"
                            }
                        ]
                    }
                ]
            }
        }
    }
}
EOF
)"
}


addTask(){
  jsontask="$1"
  if [ -z "$jsontask" ]; then
    jsontask='{"title":"Completed task","completed":true}'
  fi
  printInfo "adding task $jsontask"
  response=$(curl -s -X POST $APPLICATION_URL/todos \
    -H "Content-Type: application/json" -d "$jsontask")
  
  if echo "$response" | grep -q '"status":"ok"'; then
    printInfo "✅ Task added successfully"
  else
    printInfo "❌ Failed to add task"
  fi
}


clearCompletedTasks(){
  printInfo "Clearing completed Tasks"
  response=$(curl -s -X DELETE $APPLICATION_URL/todos/clear_completed)
  if echo "$response" | grep -q '"status":"ok"'; then
    printInfo "✅ Clear completed executed successfully"
  else
    printInfo "❌ Failed to execute Clear completed"
  fi

}