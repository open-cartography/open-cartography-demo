# Makefile for copying a folder from src to dest

# Set the source and destination directories
SRC_DIR = config
DEST_DIR = opentelemetry-demo

JAEGER_SERVICE_HOST = kubic.local

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

split: apps
	sed -i "s/^JAEGER_SERVICE_PORT=.*/JAEGER_SERVICE_PORT=$(JAEGER_SERVICE_PORT)/" $(DEST_DIR)/.env

apps: copy_config
	docker compose -f opentelemetry-demo/docker-compose.yml up --force-recreate --no-deps otelcol cartservice loadgenerator frontend frontendproxy

grafana: copy_config
	docker compose -f opentelemetry-demo/docker-compose.yml up --force-recreate  grafana

otelcol: copy_config
	docker compose -f opentelemetry-demo/docker-compose.yml up --force-recreate  otelcol

prometheus: copy_config
	docker compose -f opentelemetry-demo/docker-compose.yml up --force-recreate  prometheus

obs: copy_config
	docker compose -f opentelemetry-demo/docker-compose.yml up --force-recreate  otelcol grafana jaeger prometheus frontendproxy
