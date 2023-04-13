# Makefile for copying a folder from src to dest

# Set the source and destination directories
SRC_DIR = config
DEST_DIR = opentelemetry-demo

# overrides for split images in two machines
REMOTE_HOST = kubic.local
JAEGER_SERVICE_HOST = $(REMOTE_HOST)
PROMETHEUS_SERVICE_HOST= $(REMOTE_HOST)
GRAFANA_SERVICE_HOST= $(REMOTE_HOST)
FRONTEND_HOST= $(REMOTE_HOST)
PUBLIC_OTEL_EXPORTER_OTLP_TRACES_ENDPOINT=http://$(REMOTE_HOST):4318/v1/traces

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

split_obs: obs
	sed -i '' "s/^JAEGER_SERVICE_HOST=.*/JAEGER_SERVICE_HOST=$(JAEGER_SERVICE_HOST)/" $(DEST_DIR)/.env
	sed -i '' "s/^PROMETHEUS_SERVICE_HOST=.*/PROMETHEUS_SERVICE_HOST=$(PROMETHEUS_SERVICE_HOST)/" $(DEST_DIR)/.env
	sed -i '' "s/^GRAFANA_SERVICE_HOST=.*/GRAFANA_SERVICE_HOST=$(GRAFANA_SERVICE_HOST)/" $(DEST_DIR)/.env
	sed -i '' "s/^FRONTEND_HOST=.*/FRONTEND_HOST=$(FRONTEND_HOST)/" $(DEST_DIR)/.env
	sed -i '' "s/^PUBLIC_OTEL_EXPORTER_OTLP_TRACES_ENDPOINT=.*/PUBLIC_OTEL_EXPORTER_OTLP_TRACES_ENDPOINT=$(PUBLIC_OTEL_EXPORTER_OTLP_TRACES_ENDPOINT)/" $(DEST_DIR)/.env

split_apps: apps
	sed -i '' "s/^JAEGER_SERVICE_HOST=.*/JAEGER_SERVICE_HOST=$(JAEGER_SERVICE_HOST)/" $(DEST_DIR)/.env
	sed -i '' "s/^PROMETHEUS_SERVICE_HOST=.*/PROMETHEUS_SERVICE_HOST=$(PROMETHEUS_SERVICE_HOST)/" $(DEST_DIR)/.env
	sed -i '' "s/^GRAFANA_SERVICE_HOST=.*/GRAFANA_SERVICE_HOST=$(GRAFANA_SERVICE_HOST)/" $(DEST_DIR)/.env
	sed -i '' "s/^FRONTEND_HOST=.*/FRONTEND_HOST=$(FRONTEND_HOST)/" $(DEST_DIR)/.env
	sed -i '' "s/^PUBLIC_OTEL_EXPORTER_OTLP_TRACES_ENDPOINT=.*/PUBLIC_OTEL_EXPORTER_OTLP_TRACES_ENDPOINT=$(PUBLIC_OTEL_EXPORTER_OTLP_TRACES_ENDPOINT)/" $(DEST_DIR)/.env

apps: copy_config
	docker compose -f opentelemetry-demo/docker-compose.yml up --force-recreate --no-build  --no-deps  frontendproxy frontend kafka cartservice ffs_postgres featureflagservice loadgenerator

obs: copy_config
	docker compose -f opentelemetry-demo/docker-compose.yml up --force-recreate --no-build  --no-deps frontendproxy otelcol jaeger prometheus grafana

grafana: copy_config
	docker compose -f opentelemetry-demo/docker-compose.yml up --force-recreate  grafana

otelcol: copy_config
	docker compose -f opentelemetry-demo/docker-compose.yml up --force-recreate  otelcol

prometheus: copy_config
	docker compose -f opentelemetry-demo/docker-compose.yml up --force-recreate  prometheus
