

| Make Commands                  | Description                                                                     |
|--------------------------------|---------------------------------------------------------------------------------|
| `make build`                   | Builds the current stack                                                        |
| `make build-%`                 | Builds and pushes (base/dev/prod) images to Docker Hub with Buildx              |
| `make clean-stack`             | Stops, removes and deletes volumes, images, and networks                        |
| `make console`                 | Runs a bash for open-webui                                                      |
| `make oconsole`                | Runs a bash for ollama                                                          |
| `make qconsole`                | Runs a bash for qdrant                                                          |
| `make docker-login`            | Logs in to Docker Hub registry                                                  |
| `make download-models`         | Downloads all models defined in env OLLAMA_DOWNLOAD_MODELS                      |
| `make fix-buildx`              | Fixes a broken Buildx setup                                                     |
| `make fix-line-endings`        | Fixes the line endings of all files                                             |
| `make help`                    | Shows help for make commands                                                    |
| `make remove-buildx`           | Removes Buildx runtime container                                                |
| `make remove-models`           | Removes all ollama models                                                       |
| `make restart`                 | Cleans your stack containers, volumes, networks & restarts all services         |
| `make start`                   | Starts all services defined in your docker-compose file                         |
| `make stop`                    | Stops running Docker containers                                                 |
| `make validate-docker-compose` | Validates the docker-compose.yml file                                           |


| Make Commands ollama          | Description                                                                      |
|-------------------------------|----------------------------------------------------------------------------------|
| `make %`                      | Default target that does nothing                                                 |
| `make list-models`            | Lists all available Ollama models                                                |
| `make download-models`        | Downloads all models specified in `OLLAMA_DOWNLOAD_MODELS` environment variable  |
| `make remove-models`          | Removes all Ollama models from the system                                        |
| `make create-model`           | Creates a new custom model using the specified Modelfile                         |
| `make remove-model`           | Removes a specific model by name                                                 |
| `make pull-model`             | Pulls a specific model from the repository                                       |
