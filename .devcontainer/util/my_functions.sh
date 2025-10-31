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