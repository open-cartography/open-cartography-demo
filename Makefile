# Makefile for copying a folder from src to dest

# Set the source and destination directories
SRC_DIR = config
DEST_DIR = opentelemetry-demo

# Define the copy command
CP = cp -r -f

# Define the default target
all: fast-run

# Define the copy_folder target
copy_config:
	$(CP)	$(SRC_DIR)/*	$(DEST_DIR)/

fast-run: copy_config
	docker compose -f opentelemetry-demo/docker-compose.yml up  --force-recreate --no-build --remove-orphans

run: copy_config
	docker compose -f opentelemetry-demo/docker-compose.yml up --no-build --remove-orphans

apps: copy_config
	docker compose -f opentelemetry-demo/docker-compose.yml up --force-recreate --no-build  frontendproxy

obs: copy_config
	docker compose -f opentelemetry-demo/docker-compose.yml up --force-recreate --no-build  --no-deps frontendproxy otelcol jaeger prometheus grafana

grafana: copy_config
	docker compose -f opentelemetry-demo/docker-compose.yml up --force-recreate --no-build  --no-deps grafana frontendproxy frontend

otelcol: copy_config
	docker compose -f opentelemetry-demo/docker-compose.yml up --force-recreate  otelcol

prometheus: copy_config
	docker compose -f opentelemetry-demo/docker-compose.yml up --force-recreate  prometheus
