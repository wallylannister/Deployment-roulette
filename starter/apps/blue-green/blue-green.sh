#!/bin/bash

# Set the namespace and deployment name
 NAMESPACE="udacity" # Change this if your deployment is in a different namespace
# DEPLOYMENT_NAME="blue"

# Step 1: Get the current blue deployment configuration
# kubectl get deployment $DEPLOYMENT_NAME -n $NAMESPACE -o yaml > blue-deployment.yaml

# Step 2: Modify the deployment configuration for green deployment
# sed -i 's/blue-config/green-config/g' blue-deployment.yaml
# sed -i 's/blue/green/g' blue-deployment.yaml

# Step 3: Apply the new green deployment configuration
kubectl apply -f green.yml -n $NAMESPACE

# Step 4: Wait for the new deployment to successfully roll out
kubectl rollout status deployment/green -n $NAMESPACE

# Step 5: Check if the service is reachable
SERVICE_URL="http://blue-green.udacityproject.com" # Change this to your service URL

# Curl the service to check if it's reachable
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" $SERVICE_URL)

if [ "$HTTP_CODE" -eq 200 ]; then
    echo "Green deployment is reachable."
else
    echo "Failed to reach the green deployment. HTTP Status Code: $HTTP_CODE"
fi

# Clean up
# rm blue-deployment.yaml
