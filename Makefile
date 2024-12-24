include .env.example

# ==================================================================================== #
# DEVELOPMENT
# ==================================================================================== #
.DEFAULT_GOAL := init

.PHONY: init
init: \
	create-env \
	docker-compose-down \
	generate-env \
	build-local-and-remote \
	local-delete-ssh-volume \
	local-build \
	local-run-detached

.PHONY: create-env
create-env:
	echo "COMPOSE_PROJECT_NAME=${COMPOSE_PROJECT_NAME}" > .env

.PHONY: docker-compose-down
docker-compose-down:
	docker compose down

# ==================================================================================== #
# GROUPED COMMANDS
# ==================================================================================== #
.PHONY: generate-env
generate-env: local-env remote-env

.PHONY: build-local-and-remote
build: local-build remote-build

# ==================================================================================== #
# LOCAL COMMANDS
# ==================================================================================== #
.PHONY: local-env
local-env:
	docker compose run --rm --entrypoint /app/generate_env local >> .env

.PHONY: local-build
local-build:
	docker compose build local

.PHONY: local-delete-ssh-volume
local-delete-ssh-volume:
	docker volume rm ${COMPOSE_PROJECT_NAME}_local_ssh

.PHONY: local-run-detached
local-run-detached:
	docker compose up local -d

.PHONY: local-cat-config
local-cat-config:
	docker compose run --rm --entrypoint /bin/cat local /app/mnt/config.yaml

.PHONY: local-touch-config
local-touch-config:
	docker compose run --rm --entrypoint /bin/touch local /app/mnt/config.yaml

.PHONY: local-truncate-config
local-truncate-config:
	docker compose run --rm --entrypoint /usr/bin/truncate local -s 0 /app/mnt/config.yaml

# ==================================================================================== #
# REMOTE COMMANDS
# ==================================================================================== #
.PHONY: remote-env
remote-env:
	docker compose run --rm --entrypoint /app/generate_env remote >> .env

.PHONY: remote-build
remote-build:
	docker compose build remote

.PHONY: remote-cat-known-hosts
remote-cat-known-hosts:
	docker compose run --rm --entrypoint /bin/cat remote /root/.ssh/known_hosts

.PHONY: remote-truncate-known-hosts
remote-truncate-known-hosts:
	docker compose run --rm --entrypoint /usr/bin/truncate remote -s 0 /root/.ssh/known_hosts

.PHONY: remote-connect
remote-connect:
	docker compose run --rm --entrypoint /bin/bash remote
