#!/bin/sh
set -eu

echo 'Running startup script:'

# Wait for db to be ready: (https://docs.docker.com/compose/startup-order/)
: "${DB_ADDR:?DB_ADDR must be set}"
: "${DB_PORT:=3306}"
: "${DB_WAIT_TIMEOUT:=60}"

case "$DB_PORT" in
  *[!0-9]*|'')
    echo 'DB_PORT must be a number' >&2
    exit 64
    ;;
esac

case "$DB_WAIT_TIMEOUT" in
  *[!0-9]*|'')
    echo 'DB_WAIT_TIMEOUT must be a non-negative number' >&2
    exit 64
    ;;
esac

wait-for-it -t "$DB_WAIT_TIMEOUT" "${DB_ADDR}:${DB_PORT}"

# Additional configuration:
# echo 'Additional configuration:'
# ADD CODE HERE

# Finished:
echo 'Ready for setup: http://localhost/typo3/install.php '

exec docker-php-entrypoint "$@"
