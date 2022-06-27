#!/bin/sh

# Work in progress!

echo '[MAIN] Running startup script:'

# Wait for database container:
apt-get update
apt-get install -y wget
wget -q https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh 
chmod +x wait-for-it.sh
./wait-for-it.sh -t 0 ${DB_ADDR}:${DB_PORT}

# Cleanup:
echo '[MAIN] cleanup:'
apt-get purge -y wget
apt-get autoremove -y 
apt-get clean 
rm -rf /var/lib/apt/lists/*


# Database configuration:
echo '[MAIN] DB configuration:'
mysql -h db -e "GRANT ALL ON typo3.* TO typo3@localhost IDENTIFIED BY 'password';" 
mysql -h db -e "FLUSH PRIVILEGES;"

# Check status:
echo '[MAIN] Check apache status:'
service apache2 status

echo '[MAIN] Ready for setup: http://localhost/typo3/ '