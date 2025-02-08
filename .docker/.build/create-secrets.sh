#!/bin/bash

set -euo pipefail

ENV_FILE=".env"

if [[ ! -f "$ENV_FILE" ]]; then
    echo "Error: $ENV_FILE not found!"
    exit 1
fi

echo "Reading environment variables from $ENV_FILE and creating Docker Secrets..."

echo "swarm join-token manager"
docker swarm join-token manager

while IFS='=' read -r VAR_NAME VAR_VALUE; do
    [[ -z "$VAR_NAME" || "$VAR_NAME" =~ ^# ]] && continue

    VAR_NAME=$(echo "$VAR_NAME" | xargs)
    VAR_VALUE=$(echo "$VAR_VALUE" | xargs)

    SECRET_NAME="secret_$VAR_NAME"

    if docker secret inspect "$SECRET_NAME" &>/dev/null; then
        echo "Secret $SECRET_NAME already exists. Skipping..."
    else
        echo "$VAR_VALUE" | docker secret create "$SECRET_NAME" -
        echo "Created Docker Secret: $SECRET_NAME"
    fi
done < "$ENV_FILE"

echo "Docker Secrets created successfully."
