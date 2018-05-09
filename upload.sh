#!/bin/bash -xe

aws s3 cp codepipeline-ecs-deploy/template.yaml s3://relus-public-tools/cloudformations/codepipeline-ecs-deploy.template