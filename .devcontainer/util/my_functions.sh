#!/bin/bash
# ======================================================================
#          ------- Custom Functions -------                            #
#  Space for adding custom functions so each repo can customize as.    # 
#  needed.                                                             #
# ======================================================================


customFunction(){
  printInfoSection "This is a custom function that calculates 1 + 1"

  printInfo "1 + 1 = $(( 1 + 1 ))"

}




redeployApp(){

  IMAGE_NAME="todoapp:local"
  NAMESPACE="todoapp"
  DEPLOYMENT_NAME="todoapp"

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
  
  kubectl logs -l app=todoapp -c todoapp -n todoapp | grep 'failed to delete completed todos' > /dev/null
  click_clear_completed=$?

  if [ $mark_completed -eq 0 ] && [ $click_clear_completed -eq 0 ]; then
    printInfo "✅ Thanks for adding tasks and trying to clear them."
    return 0
  else
    printInfo " ⚠️ Please add a couple of task and then click on the 'clear completed' button"
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

}
