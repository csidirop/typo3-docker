#!/bin/sh

echo 'Running startup script:'

# Wait for db to be ready: (https://docs.docker.com/compose/startup-order/)
wait-for-it -t 0 ${DB_ADDR}:${DB_PORT}

# Additional configuration:
# echo 'Additional configuration:'
# ADD CODE HERE

# Finished:
echo 'Ready for setup: http://localhost/typo3/install.php '