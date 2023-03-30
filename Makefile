# Makefile for copying a folder from src to dest

# Set the source and destination directories
SRC_DIR = src
DEST_DIR = dest


# Define the copy command
CP = cp -r -f

# Define the default target
all: copy_config

# Define the copy_folder target
copy_config:
	$(CP)	$(SRC_DIR)/*	$(DEST_DIR)/