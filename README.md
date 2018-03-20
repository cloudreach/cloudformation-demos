# codepipeline-ecs-demo

Demo application deployed to ECS Fargate by CodePipeline

# Setup

To setup the demo pipeline, `run bootstrap/initialize.sh`. This will create a
code commit repo and associated pipeline. Commit this directory to the repo created
on the master branch. You can use the instructions provided in the CodeCommit UI to push.

# Deployment

Any time a deployment is made to the `master` branch, the pipeline will trigger via 
CloudWatch events and push the Docker image created by the `Dockerfile` to the ECR 
repository created in the bootstrap CloudFormation stack. The build specifications
are detailed in `build/buildspec.yaml`.

Once the Docker image has been pushed, the stack created by `build/deploy.yaml` is 
deployed via CloudFormation.