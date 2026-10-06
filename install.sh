#!/bin/bash

# stop script when exit doesnt return 0
set -e
# goes to the scripts dir
cd $(dirname $0)

# tries to find docker path and verify error code
if ! command -v docker &> /dev/null; then
    echo "Docker not found. Install Docker Engine first."
    exit 1
fi

# tries to see if docker service is up, using the same mechanic
if ! docker info &> /dev/null; then
    echo "Docker daemon not running. Starting it..."
    sudo systemctl start docker
fi

# creates volumes path, docker can do it but it could bring permission issues
mkdir -p mariadb_data dolibarr_documents dolibarr_custom
docker compose up -d

sleep 3

echo "Dolibarr is up at http://localhost:8080"
echo "Admin login: admin / admin (change immediately)"
