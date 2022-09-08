#!/bin/sh

# Work in progress!

echo '[MAIN] Running startup script:'

# Wait for db to be ready:
wait-for-it -t 0 ${DB_ADDR}:${DB_PORT}

# Database configuration:
echo '[MAIN] DB configuration:'
mysql -h db -e "GRANT ALL ON typo3.* TO typo3@localhost IDENTIFIED BY 'password';"
mysql -h db -e "FLUSH PRIVILEGES;"

# Check status:
echo '[MAIN] Check apache status:'
service apache2 status

echo '[MAIN] Ready for setup: http://localhost/typo3/ '