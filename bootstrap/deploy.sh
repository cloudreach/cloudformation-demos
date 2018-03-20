#!/bin/bash -xe

export AWS_DEFAULT_REGION=us-east-1

TEMPLATE_PKG=pipeline-package.yaml

# clean old
if [ -f ${TEMPLATE_PKG} ]; then
	rm ${TEMPLATE_PKG}
fi

# create new
aws cloudformation package \
	--template-file pipeline.yaml \
	--s3-bucket kwilson.reluslabs.com \
	--output-template-file ${TEMPLATE_PKG}

# validate the template
aws cloudformation validate-template --template-body file://${TEMPLATE_PKG}

# deploy it
aws cloudformation deploy \
	--template-file ${TEMPLATE_PKG} \
	--stack-name codepipeline-docker-ecs \
	--capabilities CAPABILITY_NAMED_IAM \
	--parameter-overrides ApplicationName=ecs-docker