include ./.env.dist
-include ./.env
export

include ./.makefile/Makefile.color
include ./.makefile/Makefile.function
include ./.makefile/Makefile.ollama
include ./.makefile/Makefile.killer

.DEFAULT_GOAL := help
OUTPUT := @
MAKEFLAGS += --no-print-directory

DOCKER_COMPOSE := docker compose
OLLAMA := $(DOCKER_COMPOSE) exec -e OUTPUT=$(OUTPUT) -it ollama
OLLAMA_EXECUTE := $(OLLAMA) bash

OPENWEBUI := $(DOCKER_COMPOSE) exec -e OUTPUT=$(OUTPUT) -it open-webui
OPENWEBUI_EXECUTE := $(OPENWEBUI) bash

QDRANT := $(DOCKER_COMPOSE) exec -e OUTPUT=$(OUTPUT) -it qdrant
QDRANT_EXECUTE := $(QDRANT) bash

DOCKER_CONTAINER := $(DOCKER_CONTAINER)
DEV_IMAGE_TAG := $(DEV_IMAGE_TAG)
BASE_IMAGE_TAG := $(BASE_IMAGE_TAG)
PLATFORMS := $(PLATFORMS)

start:
	$(call measure_time, start-callback)

restart:
	$(call measure_time, restart-callback)

stop:
	$(DOCKER_COMPOSE) down --remove-orphans

help:
	$(OUTPUT)printf $(COLOR_GREEN)
	$(OUTPUT)bash -c "tail -500 README.makefile.md"
	$(OUTPUT)printf $(COLOR_OFF)"\n\n"

console:
	$(OUTPUT)$(OPENWEBUI_EXECUTE)

oconsole:
	$(OUTPUT)$(OLLAMA_EXECUTE)

qconsole:
	$(OUTPUT)$(QDRANT_EXECUTE)

build: \
	docker-login
	DOCKER_BUILDKIT=1 $(DOCKER_COMPOSE) build --pull --compress --parallel --force-rm

clean-stack:
	$(DOCKER_COMPOSE) down -v --rmi all --remove-orphans

validate-docker-compose:
	$(OUTPUT)$(DOCKER_COMPOSE) config --quiet && \
	printf $(COLOR_GREEN)"docker-compose.yml OK\n"$(COLOR_OFF) || \
	printf $(COLOR_RED)"docker-compose.yml ERROR\n"$(COLOR_OFF) exit 1

docker-login:
	$(OUTPUT)echo ${DOCKER_PASS} | docker login -u ${DOCKER_REPO_USER} --password-stdin

fix-line-endings:
	$(OUTPUT)find . -type f -print0 | xargs -0 dos2unix

build-%:
	$(call measure_time, build-$*-callback)

start-callback: \
	docker-login \
	build
	$(OUTPUT)$(DOCKER_COMPOSE) up -d --force-recreate
	$(OUTPUT)printf $(COLOR_GREEN)"\n\n"
	$(OUTPUT)bash -c "tail -500 README.makefile.md"
	$(OUTPUT)printf $(COLOR_OFF)
	$(OUTPUT)printf $(COLOR_GREEN)"\n Docker containers built and started! \n\n"$(COLOR_OFF)

restart-callback: \
	clean-stack \
	start-callback

build-%-callback:
	$(call buildx-build, $*)

docker-pull-images: \
	docker-login
	$(OUTPUT)printf $(COLOR_BLUE)"\nPulling all images from DOCKER_CONTAINER: $(DOCKER_CONTAINER)\n"$(COLOR_OFF)
	@for container in $(shell echo $(DOCKER_CONTAINER) | tr ',' ' '); do \
		printf $(COLOR_GREEN)"Pulling image: $(DOCKER_REPO_NAME)/$$container:$(PROD_IMAGE_TAG)...\n"$(COLOR_OFF); \
		if docker pull $(DOCKER_REPO_NAME)/$$container:$(PROD_IMAGE_TAG); then \
			printf $(COLOR_GREEN)"Successfully pulled: $(DOCKER_REPO_NAME)/$$container:$(PROD_IMAGE_TAG)\n"$(COLOR_OFF); \
		else \
			printf $(COLOR_RED)"Failed to pull: $(DOCKER_REPO_NAME)/$$container:$(PROD_IMAGE_TAG)\n"$(COLOR_OFF); \
		fi; \
	done
	$(OUTPUT)printf $(COLOR_GREEN)"\nAll images processed.\n"$(COLOR_OFF)


logo-callback:
	APP_NAME=$(APP_NAME)
	$(OUTPUT)printf $(COLOR_BLUE)
	$(OUTPUT)awk '{printf "%10s%s\n", "", $$0}' .makefile/assets/logo.asci
	$(OUTPUT)printf $(COLOR_WHITE)
	echo  '                                                             '
	echo  "                             $$APP_NAME                      "
	$(OUTPUT)printf $(COLOR_BLUE)
	echo  '                                                             '
	echo  '                  Opillion GmbH & Co KG (GPL-3.0 2025)       '
	$(OUTPUT)printf $(COLOR_OFF)"\n\n"
