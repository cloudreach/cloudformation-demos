#!/bin/bash -xe

APP_NAME=$1
TEMPLATE=pipeline.yaml
STACK=${APP_NAME}-pipeline

if [ -z ${APP_NAME} ]; then
	printf "Application name is required"
	exit 1
fi

export AWS_DEFAULT_REGION=us-east-1

# validate the template
aws cloudformation validate-template --template-body file://${TEMPLATE}

# deploy it
set +e
aws cloudformation describe-stack-events --stack-name ${STACK}
EXISTS=$?
set -e

if [[ ${EXISTS} -eq 0 ]]; then
	aws cloudformation update-stack \
		--template-body "`cat ${TEMPLATE}`" \
    	--stack-name ${STACK} \
    	--capabilities CAPABILITY_NAMED_IAM \
    	--parameters ParameterKey=ApplicationName,UsePreviousValue=true
else
	aws cloudformation deploy \
		--template-file "${TEMPLATE}" \
		--stack-name ${STACK} \
		--capabilities CAPABILITY_NAMED_IAM \
		--parameter-overrides ApplicationName=${APP_NAME} \
			ContainerPort=80 \
			Cpu=256 \
			Memory=512
fi
