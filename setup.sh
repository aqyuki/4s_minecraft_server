#!/bin/bash

CREATE_DIR=(data backups)

echo "Creating directories if they don't exist"
for dir in ${CREATE_DIR[@]}; do
    if [ ! -d $dir ]; then
        mkdir $dir
        echo "Created directory: $dir"
    else
        echo "Directory already exists: $dir"
    fi
done

echo "Pulling latest images"
docker compose pull

echo "Setup complete"
exit 0
