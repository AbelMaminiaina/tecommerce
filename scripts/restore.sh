#!/bin/bash

# Restore script for Odoo database
# Usage: ./scripts/restore.sh [dev|test|preprod|prod] [backup_file.sql.gz]

ENVIRONMENT=${1:-dev}
BACKUP_FILE=$2
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

if [ -z "$BACKUP_FILE" ]; then
    echo "Usage: ./scripts/restore.sh [dev|test|preprod|prod] [backup_file.sql.gz]"
    echo ""
    echo "Available backups for $ENVIRONMENT:"
    ls -lh "$PROJECT_ROOT/data/backups/$ENVIRONMENT"/*.sql.gz 2>/dev/null || echo "No backups found"
    exit 1
fi

if [ ! -f "$BACKUP_FILE" ]; then
    echo "Error: Backup file not found: $BACKUP_FILE"
    exit 1
fi

DB_CONTAINER="odoo-db-$ENVIRONMENT"
DB_NAME="odoo_$ENVIRONMENT"

echo "WARNING: This will replace the current database with the backup!"
echo "Environment: $ENVIRONMENT"
echo "Backup file: $BACKUP_FILE"
echo ""
read -p "Are you sure you want to continue? (yes/no): " CONFIRM

if [ "$CONFIRM" != "yes" ]; then
    echo "Restore cancelled."
    exit 0
fi

echo ""
echo "Stopping Odoo container..."
docker-compose -f "$PROJECT_ROOT/docker/docker-compose.yml" --profile "$ENVIRONMENT" stop odoo-$ENVIRONMENT

echo "Dropping existing database..."
docker exec -t "$DB_CONTAINER" psql -U odoo -d postgres -c "DROP DATABASE IF EXISTS $DB_NAME;"

echo "Creating new database..."
docker exec -t "$DB_CONTAINER" psql -U odoo -d postgres -c "CREATE DATABASE $DB_NAME OWNER odoo;"

echo "Restoring database from backup..."
gunzip < "$BACKUP_FILE" | docker exec -i "$DB_CONTAINER" psql -U odoo -d "$DB_NAME"

echo "Starting Odoo container..."
docker-compose -f "$PROJECT_ROOT/docker/docker-compose.yml" --profile "$ENVIRONMENT" start odoo-$ENVIRONMENT

echo ""
echo "Database restored successfully!"
echo "Note: Filestore must be restored manually if needed."
