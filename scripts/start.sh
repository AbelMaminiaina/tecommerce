#!/bin/bash

# Start script for Odoo environments
# Usage: ./scripts/start.sh [dev|test|preprod|prod]

ENVIRONMENT=${1:-dev}
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_ROOT/docker" || exit 1

echo "Starting Odoo $ENVIRONMENT environment..."

# Load environment variables
if [ -f "$PROJECT_ROOT/.env" ]; then
    export $(cat "$PROJECT_ROOT/.env" | grep -v '^#' | xargs)
fi

# Start the environment
docker-compose --profile "$ENVIRONMENT" up -d

# Wait for services to be ready
echo "Waiting for services to start..."
sleep 5

# Show status
docker-compose --profile "$ENVIRONMENT" ps

echo ""
echo "Odoo $ENVIRONMENT is starting!"
echo ""
case "$ENVIRONMENT" in
    dev)
        echo "Access Odoo at: http://localhost:8069"
        echo "Debugger port: 5678"
        ;;
    test)
        echo "Access Odoo at: http://localhost:8070"
        ;;
    preprod)
        echo "Access Odoo at: http://localhost:8071"
        ;;
    prod)
        echo "Access Odoo at: http://localhost:8072"
        ;;
esac
echo ""
echo "View logs with: docker-compose --profile $ENVIRONMENT logs -f"
