#!/bin/sh
export IMAGE_NAME=fzaben/capstone-app:$BUILD_NUMBER
kubectl  --namespace=default set image deployment/capstone-app-dep capstone-app=$IMAGE_NAME --record=true
