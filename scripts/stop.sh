#!/bin/bash

# Stop script for Odoo environments
# Usage: ./scripts/stop.sh [dev|test|preprod|prod|all]

ENVIRONMENT=${1:-dev}
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_ROOT/docker" || exit 1

if [ "$ENVIRONMENT" = "all" ]; then
    echo "Stopping all Odoo environments..."
    docker-compose --profile dev --profile test --profile preprod --profile prod down
else
    echo "Stopping Odoo $ENVIRONMENT environment..."
    docker-compose --profile "$ENVIRONMENT" down
fi

echo "Environment(s) stopped successfully."
