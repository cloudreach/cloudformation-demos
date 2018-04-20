# codepipeline-ecs-demo

Demo application deployed to ECS Fargate using CodePipeline.

# Setup

* Create a CloudFormation stack with the pipeline.yaml template.
* Push a `Dockerfile` and `buildspec.yaml` to the CodeCommit repository created by the template. You can find examples 
of these in the example folder.


# Deployment

Any time a deployment is made to the `master` branch, the pipeline will trigger via 
CloudWatch events, build and push the docker image, and use the `images.json` to update the
service's task definition. An example build specification is located in `example/buildspec.yaml`.
