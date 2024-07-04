#!/bin/sh

echo '[MAIN] Running startup script:'

# Wait for db to be ready: (https://docs.docker.com/compose/startup-order/)
wait-for-it -t 0 ${DB_ADDR}:${DB_PORT}

# Additional configuration:
# echo '[MAIN] Additional configuration:'
# ADD CODE HERE

# Finished:
echo 'Ready for setup: http://localhost/typo3/install.php '