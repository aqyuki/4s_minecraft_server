#!/bin/bash
# This script is used to backup a minecraft server

# If any command fails, stop the script
set -e

# set variables
SCRIPT_DIR="$(cd $(dirname $0); pwd)"
WORLD_DIR="$SCRIPT_DIR/server/worlds/world"
BACKUP_DIR="$SCRIPT_DIR/backups"
BACKUP_FILE="$BACKUP_DIR/$(date +%F-%H-%M)-world.zip"

# if the backup directory doesn't exist, create it
if [ ! -d "$BACKUP_DIR" ]; then
  echo "Creating backup directory: $BACKUP_DIR"
  mkdir -p "$BACKUP_DIR"
fi

# create a backup of the world
if [ ! -d "$WORLD_DIR" ]; then
  echo "The world directory does not exist. Backup aborted." >&2
  exit 1
else
  echo "Starting backup of world: $WORLD_DIR"
  if zip -r "$BACKUP_FILE" "$WORLD_DIR" > /dev/null; then
    echo "Backup successful: $BACKUP_FILE"
  else
    echo "Backup failed! Please check if the world directory exists and try again." >&2
    exit 1
  fi
  echo "Backup process completed."
  exit 0
fi
