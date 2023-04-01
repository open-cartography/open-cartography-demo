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
	docker compose -f opentelemetry-demo/docker-compose.yml up

grafana:
	docker compose -f opentelemetry-demo/docker-compose.yml up --force-recreate  grafana

otelcol:
	docker compose -f opentelemetry-demo/docker-compose.yml up --force-recreate  otelcol
