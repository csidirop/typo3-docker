# typo3-docker
This repo provides a simple docker image for Typo3 r11.

# Build image:
'docker build -t csidirop/typo3-v11:11.5 .'

# Run image:
'docker run -p 80:80 csidirop/typo3-v11:11.5'

# Tmp workaround: start mariadb: 
# (gets obsolete when docker-compose works)
Get container hash:  'docker ps'
start mariadb in container:  'docker exec <container hash> service mariadb start'

# Set up typo3 with typo3 install tool in your browser:
http://localhost/typo3/install.php