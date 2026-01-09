#!/bin/bash
# wait-for-psql.sh - Wait for PostgreSQL to be ready

set -e

host="$1"
shift
cmd="$@"

until PGPASSWORD=$PASSWORD psql -h "$host" -U "$USER" -c '\q' 2>/dev/null; do
  echo "PostgreSQL is unavailable on $host - sleeping"
  sleep 1
done

echo "PostgreSQL is up on $host - executing command"
exec $cmd
