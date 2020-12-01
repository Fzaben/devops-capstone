# Udacity Cloud DevOps Nanodegree Capstone Project
[Udacity Cloud DevOps Cloud Engineer Nanodegree Capstone Project]

http://abefb74d1177f4dcf9c39449b9f4f29f-187350353.us-west-2.elb.amazonaws.com/

## Project Overview
As a capstone-app workflow, deploying a simple hello world app inside nginx docker image running in esk using cloudformation, docker, kubernetes for setup the infrastructrue and jenkins for pipeline orchestration running in docker container localy with it secret configuration for running docker and applt kubectl commands inside that container with 3 pipeline stages (lint, integration, deploy' RollingUpdate') for ci-cd.   


### prerequest tools and services
- nginx
- docker
- kubectl
- make
- Jenkins
- hadolint
- CloudFormation
- aws-cli
- jenkins
- git bash
- docker-hub
- aws esk


### CloudFormation 
- `./iac/create_stack.sh devops-capstone-netowrk iac/network/network.yml iac/network/params.json` Creating application infastructure

- `./iac/create_stack.sh devops-capstone-cluster iac/cluster/cluster.yml iac/cluster/params.json` Creating k8s cluster (get the iac/cluster/params.json variables from awscli or the aws console)
https://us-west-2.console.aws.amazon.com/cloudformation/home?region=us-west-2#/stacks/resources?filteringText=&filteringStatus=active&viewNested=true&hideStacks=false&stackId=arn%3Aaws%3Acloudformation%3Aus-west-2%3A582512839761%3Astack%2Fdevops-capstone-netowrk%2F1a9383f0-3408-11eb-b8a6-0ab16b781def

- `./iac/create_stack.sh devops-capstone-nodes iac/nodes/nodes.yml iac/nodes/params.json` Creating k8s nodes
(get the iac/nodes/params.json variables from awscli or the aws console)
https://console.aws.amazon.com/iam/home#/roles/devops-capstone-cluster-ClusterRole-1Q0HMW5MIEYS9


- `./iac/create_stack.sh devops-capstone-ecr iac/ecr/cluster.yml iac/ecr/params.json` Creating k8s container registry but I'm using docker-hub  



### Deploy the application
Retrieve an authentication token and authenticate your Docker client to your registry.
Use the AWS CLI:
- `aws ecr get-login-password --region <regoin>| docker login --username <username> --password-stdin <url-regstiry>`
Use docker-hub
- `docker login --username <username> --password-stdin <url-regstiry>`

Note: If you receive an error using the AWS CLI, make sure that you have the latest version of the AWS CLI and Docker installed.
Build your Docker image using the following command. For information on building a Docker file from scratch see the instructions here . You can skip this step if your image is already built:
- `docker build -t fzaben/capstone-app:latest .`

Run the following command to push this image to your newly created docker-hub repository:
`docker push fzaben/capstone-app:latest`

`aws eks --region us-west-2 update-kubeconfig --name devops-capstone-cluster` intgrate kubectl with eks frok aws    
- Run `kubectl apply -f ./iac/k8s/configmap.yml` integrate k8s 
- Run `kubectl apply -f ./iac/k8s/deployment.yml` add the deployment capsotne app in the k8s 
- Run `kubectl apply -f ./iac/k8s/service.yml` add loadbalancer for the running deployment


## Jenkins
Run Jenkins in [Docker](https://www.docker.com/products/docker-desktop):

```
docker-compose -f jenkins/docker-compose.yml up -d
```

> Plugins configured in [install-plugins.groovy](../jenkins/20.04/scripts/install-plugins.groovy)

Log into Jenkins at http://localhost:8080 with `psod`/`psod`.


the pipeline workflow start with 3 stages 

- Lint 

using makefile with `make` tool and run hadolint as container to lint the Dockerfile

- Integration 
using ./scripts/integration/build.sh script file will build a capstone-app and push it to docker-hub repo using `docker-compose`


- Deploy 
using ./scripts/deploy/deploy.sh script file will replace pods old image with new one using `kubectl` (RollingUpdate)


