#!/bin/bash -xe

APP_NAME=cpl-ecs-demo
TEMPLATE=pipeline.yaml

export AWS_DEFAULT_REGION=us-east-1

# validate the template
aws cloudformation validate-template --template-body file://${TEMPLATE}

# deploy it
aws cloudformation deploy \
	--template-file ${TEMPLATE} \
	--stack-name ${APP_NAME} \
	--capabilities CAPABILITY_NAMED_IAM \
	--parameter-overrides ApplicationName=${APP_NAME}