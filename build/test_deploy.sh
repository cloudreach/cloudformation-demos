#!/bin/bash -xe

export AWS_DEFAULT_REGION=us-east-1
APP_NAME=cpl-ecs-demo
TEMPLATE=deploy.yaml
ACCOUNT_ID=`aws sts get-caller-identity --query Account --output text`

aws cloudformation deploy \
	--template-file "${TEMPLATE}" \
	--stack-name "${APP_NAME}-deploy" \
	--capabilities CAPABILITY_NAMED_IAM \
	--parameter-overrides \
		"ClusterNameParameter=${APP_NAME}" \
		"ContainerNameParameter=${APP_NAME}" \
		"ContainerImageParameter=${ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${APP_NAME}" \
		"ContainerVersionParameter=latest"
