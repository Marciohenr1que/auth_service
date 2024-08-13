#!/bin/bash

set -e



# Remove a potentially pre-existing server.pid for Rails.
rm -f tmp/pids/server.pid

# Wait for the PostgreSQL server to start
echo "Waiting for PostgreSQL to be ready..."
until pg_isready -h "$POSTGRES_HOST" -p "$POSTGRES_PORT" -U "$POSTGRES_USER"; do
  echo "PostgreSQL is not ready yet..."
  sleep 2
done

# Run database migrations
echo "Running database migrations..."
bin/rails db:create || true
bin/rails db:migrate

# Start the Rails server
echo "Starting Rails server..."
exec "$@"