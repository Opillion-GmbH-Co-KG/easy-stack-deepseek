ARG BASE_IMAGE_TAG=latest
ARG DOCKER_REPO_NAME=opillion
FROM ${DOCKER_REPO_NAME}/ollama:${BASE_IMAGE_TAG}

RUN apt-get update && apt-get install -y wget jq && rm -rf /var/lib/apt/lists/*

ADD .docker/dev/ollama/script/download-models.sh /opt/download-models.sh
ADD .docker/dev/ollama/script/remove-models.sh /opt/remove-models.sh

RUN chmod +x /opt/download-models.sh /opt/remove-models.sh

