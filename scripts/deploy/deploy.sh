#!/bin/sh
export IMAGE_NAME=fzaben/capstone-app:$BUILD_NUMBER
kubectl  --kubeconfig=/root/.kube/config --namespace=default set image deployment/capstone-app-dep capstone-app=$IMAGE_NAME --record=true
