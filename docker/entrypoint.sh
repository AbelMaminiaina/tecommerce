#!/bin/bash
# entrypoint.sh - Custom entrypoint for Odoo container

set -e

# Wait for PostgreSQL to be ready
if [ -n "$HOST" ]; then
    echo "Waiting for PostgreSQL at $HOST..."
    until PGPASSWORD=$PASSWORD psql -h "$HOST" -U "$USER" -p "$PORT" -d postgres -c '\q' 2>/dev/null; do
        echo "PostgreSQL is unavailable on $HOST:$PORT - sleeping"
        sleep 1
    done
    echo "PostgreSQL is up on $HOST:$PORT"
fi

# Execute the command
case "$1" in
    python3)
        # Running Odoo from source - pass database password via command line
        exec "$@" --db_password="$DB_PASSWORD"
        ;;
    *)
        exec "$@"
        ;;
esac
