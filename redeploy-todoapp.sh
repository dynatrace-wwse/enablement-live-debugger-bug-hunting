#!/bin/bash
set -e

IMAGE_NAME="todoapp:local"
NAMESPACE="todoapp"
DEPLOYMENT_NAME="todoapp"

echo "Building local image"
docker build -t $IMAGE_NAME app

echo "Loading image into kind cluster"
kind load docker-image $IMAGE_NAME

echo "Updating deployment image"
kubectl set image deployment/$DEPLOYMENT_NAME $DEPLOYMENT_NAME=$IMAGE_NAME -n $NAMESPACE

echo "Restarting deployment to apply changes"
kubectl rollout restart deployment/$DEPLOYMENT_NAME -n $NAMESPACE

echo "Waiting for rollout to complete"
kubectl rollout status deployment/$DEPLOYMENT_NAME -n $NAMESPACE

echo "Done"