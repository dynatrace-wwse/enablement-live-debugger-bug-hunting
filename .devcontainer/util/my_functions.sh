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

  docker build -t $IMAGE_NAME app

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


assert_bug1(){
  
  kubectl logs -l app=todoapp -c todoapp -n todoapp | grep 'completed=true' > /dev/null
  mark_completed=$?
  
  kubectl logs -l app=todoapp -c todoapp -n todoapp | grep 'Failed to delete completed todos' > /dev/null
  click_clear_completed=$?

  if [ $mark_completed -eq 0 ] && [ $click_clear_completed -eq 0 ]; then
    printInfo "🪲 Bug 'Clear completed' is there! Thanks for adding tasks and trying to clear them."
    return 0
  else
    printInfo " ⚠️ Please add a couple of task, mark them completed and then click on the 'clear completed' button in order to see if the 🪲 bug is there..."
    return 1
  fi

}

assert_bug1_solved(){
  addCompletedTask

  clearCompletedTasks

  kubectl logs -l app=todoapp -c todoapp -n todoapp | grep 'Removed Todo record.*completed=true' > /dev/null
  found_removed=$?

  if [ $found_removed -eq 0 ]; then
    printInfo "✅ Bug clear completed is gone."
    return 0
  else
    printInfo "⚠️ Bug clear completed is still there, tip: check the Arrays"
    return 1
  fi

}

solve_bug1(){
  
  printInfoSection "Solving the Bug Clear Completed"

  printInfo "we change to the branch solution/bug1 where the developer already added the solution for us"

  printInfo "git checkout solution/bug1"

  git checkout solution/bug1

  printInfo "then we compile the application and redeploy it to the Kubernetes Cluster using the function 'redeployApp'"
  
  redeployApp

  printInfo "Now add some tasks, mark them completed and click on 'clear completed'"

  setVersionControl "solution/bug1"

}

setVersionControl(){

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

  echo "Fetching git revision for $version in $DT_LIVEDEBUGGER_REMOTE_ORIGIN" 
  echo $DT_LIVEDEBUGGER_COMMIT

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
                        "name": "$IMAGE_NAME",
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



# Testing Methods

addCompletedTask(){
  printInfo "adding completed Task"
  response=$(curl -s -X POST $APPLICATION_URL/todos \
    -H "Content-Type: application/json" -d '{"title":"Completed task","completed":true}')
  
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