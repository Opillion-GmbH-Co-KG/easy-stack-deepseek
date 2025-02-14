#!/bin/bash
set -e

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ] || \
   [ -z "$5" ] || [ -z "$6" ] || [ -z "$7" ] || [ -z "$8" ] || [ -z "$9" ] || [ -z "${10}" ] || [ -z "${11}" ]; then
  echo "Usage: $0 USER_ID GROUP_ID CONTAINERS DOCKER_REPO_USER" \
       "DOCKER_PASS IMAGE_TAG DOCKER_USER PLATFORMS BASE_IMAGE_TAG PROD_IMAGE_TAG DOCKER_IMAGE_SOURCE"
  exit 1
fi

USER_ID="$1"
GROUP_ID="$2"
IFS=',' read -r -a containers <<< "$3"
DOCKER_REPO_USER="$4"
DOCKER_PASS="$5"
DEV_IMAGE_TAG="$6"
DOCKER_USER="$7"
IFS=',' read -r -a platforms <<< "$8"
BASE_IMAGE_TAG="$9"
PROD_IMAGE_TAG="${10}"
DOCKER_IMAGE_SOURCE="${11}"

export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

docker_login() {
  echo "$DOCKER_PASS" | docker login -u "$DOCKER_REPO_USER" --password-stdin
}

buildx_docker_image() {
  local image_name=$1

BUILD_IMAGE_TAG=""
  if [[ "$DOCKER_IMAGE_SOURCE" == "base" ]]; then
    BUILD_IMAGE_TAG=$BASE_IMAGE_TAG
  fi

  if [[ "$DOCKER_IMAGE_SOURCE" == "dev" ]]; then
    BUILD_IMAGE_TAG=$DEV_IMAGE_TAG
  fi

  if [[ "$DOCKER_IMAGE_SOURCE" == "prod" ]]; then
    BUILD_IMAGE_TAG=$PROD_IMAGE_TAG
  fi

  echo "Building Stack for Container: $image_name"
  docker buildx create --use

  docker buildx build \
    --push \
    --platform "$PLATFORMS" \
    -t "$DOCKER_REPO_USER"/"$image_name":"$BUILD_IMAGE_TAG" \
    --build-arg DOCKER_USER="$DOCKER_USER" \
    --build-arg USER_ID="$USER_ID" \
    --build-arg GROUP_ID="$GROUP_ID" \
    --build-arg BASE_IMAGE_TAG="$BASE_IMAGE_TAG" \
    --build-arg DEV_IMAGE_TAG="$DEV_IMAGE_TAG"  \
    --build-arg DEV_IMAGE_TAG="$DEV_IMAGE_TAG" \
    --build-arg PROD_IMAGE_TAG="$PROD_IMAGE_TAG"  \
    -f .docker/"$DOCKER_IMAGE_SOURCE"/"$image_name".Dockerfile \
    .

  echo "Build done for: $image_name"
}

docker_login

for container in "${containers[@]}";
do
  buildx_docker_image "$container"
done

echo "All Containers build, tagged and pushed to $DOCKER_REPO_USER!"
