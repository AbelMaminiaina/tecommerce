#!/bin/bash

# Backup script for Odoo database and filestore
# Usage: ./scripts/backup.sh [dev|test|preprod|prod]

ENVIRONMENT=${1:-dev}
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
BACKUP_DIR="$PROJECT_ROOT/data/backups/$ENVIRONMENT"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Database backup
DB_CONTAINER="odoo-db-$ENVIRONMENT"
DB_NAME="odoo_$ENVIRONMENT"
BACKUP_FILE="$BACKUP_DIR/${DB_NAME}_${TIMESTAMP}.sql.gz"

echo "Backing up database: $DB_NAME"
docker exec -t "$DB_CONTAINER" pg_dump -U odoo -d postgres | gzip > "$BACKUP_FILE"

# Filestore backup
FILESTORE_DIR="$PROJECT_ROOT/data/filestore/$ENVIRONMENT"
FILESTORE_BACKUP="$BACKUP_DIR/filestore_${TIMESTAMP}.tar.gz"

if [ -d "$FILESTORE_DIR" ] && [ "$(ls -A $FILESTORE_DIR)" ]; then
    echo "Backing up filestore..."
    tar -czf "$FILESTORE_BACKUP" -C "$FILESTORE_DIR" .
else
    echo "Filestore is empty, skipping..."
fi

echo ""
echo "Backup completed:"
echo "  Database: $BACKUP_FILE"
if [ -f "$FILESTORE_BACKUP" ]; then
    echo "  Filestore: $FILESTORE_BACKUP"
fi
echo ""

# Clean old backups (keep last 7 days)
echo "Cleaning old backups (keeping last 7 days)..."
find "$BACKUP_DIR" -name "*.sql.gz" -mtime +7 -delete 2>/dev/null
find "$BACKUP_DIR" -name "*.tar.gz" -mtime +7 -delete 2>/dev/null

echo "Backup process completed successfully!"
