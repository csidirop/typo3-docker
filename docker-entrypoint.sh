#!/bin/sh


# Wait for database container
wget -q https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh 
chmod +x wait-for-it.sh
wait-for-it.sh -t 0 ${DB_ADDR}:${DB_PORT}


# Database configuration
mysql -h db -e "GRANT ALL ON typo3.* TO typo3@localhost IDENTIFIED BY 'password';" 

mysql -h db -e "FLUSH PRIVILEGES;"


# Run CMD
service apache2 restart
