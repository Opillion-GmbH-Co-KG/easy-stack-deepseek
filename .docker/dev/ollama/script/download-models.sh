#!/bin/bash

if [ -z "$OLLAMA_DOWNLOAD_MODELS" ]; then
    echo "Error: The OLLAMA_MODELS environment variable is not set."
    echo "Please set it as a space-separated list of models."
    echo "Example: export OLLAMA_DOWNLOAD_MODELS='deepseek-r1:1.5b deepseek-r1:7b deepseek-r1:8b'"
    exit 1
fi

echo "Checking installed models..."
INSTALLED_MODELS=$(ollama list | awk '{print $1}')

IFS=',' read -r -a MODELS_ARRAY <<< "$OLLAMA_DOWNLOAD_MODELS"

for MODEL in "${MODELS_ARRAY[@]}"; do

    if echo "$INSTALLED_MODELS" | grep -q "^$MODEL$"; then
        echo "Model $MODEL is already installed. Skipping..."
        continue
    fi

    echo "Downloading model: $MODEL ..."

    ollama pull "$MODEL" | while read -r line; do
        if echo "$line" | grep -q "progress"; then
            echo "$line" | jq -r '.progress'
        else
            echo "$line"
        fi
    done

    echo "Download completed for $MODEL."
done

echo "All requested models are now installed!"
