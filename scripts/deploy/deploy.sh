#!/bin/sh
export IMAGE_NAME=fzaben/capstone-app:$BUILD_NUMBER
kubectl   --kubeconfig=/root/.kube/config --namespace=dep set image deployment/capstone-app-dep capstone-app-dep=$IMAGE_NAME --record=true
