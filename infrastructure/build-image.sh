#!/bin/bash
IMAGE=$1
gcloud auth configure-docker europe-west2-docker.pkg.dev
docker buildx build --platform linux/amd64 -t $IMAGE ../src
docker push $IMAGE