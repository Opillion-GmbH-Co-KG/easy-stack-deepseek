#!/bin/bash

echo "Checking installed models..."
INSTALLED_MODELS=$(ollama list | awk '{print $1}')

if [ -z "$INSTALLED_MODELS" ]; then
    echo "No installed models found. Exiting."
    exit 0
fi

for MODEL in $INSTALLED_MODELS; do
    echo "Removing model: $MODEL ..."
    ollama rm "$MODEL"
    echo "Model $MODEL removed."
done

echo "All installed models have been removed!"

