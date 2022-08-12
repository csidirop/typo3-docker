# Typo3 Docker
This repo provides a simple docker image for [Typo3](https://typo3.org/).

All branches are WIP!

# Docker instructions
### Select branch
There are different [Branches](https://github.com/csidirop/typo3-docker/branches) that serve to provide different installations. Those provide following versions:

| branch      	| typo3 version 	| php version 	| OS                 	| base image                                                                                                                           	|
|-------------	|---------------	|-------------	|--------------------	|--------------------------------------------------------------------------------------------------------------------------------------	|
| main        	| v11.x         	| 7.4         	| Debian 11 Bullseye 	| [php:7.4-apache](https://github.com/docker-library/php/blob/e4509d18e3cddd03e796dd6fd4fef88070ee5132/7.4/bullseye/apache/Dockerfile) 		|
| [typo3-v11.x](https://github.com/csidirop/typo3-docker/tree/typo3-v11.x) 	| v11.5         	| 7.4         	| Debian 11 Bullseye 	| [php:7.4-apache](https://github.com/docker-library/php/blob/e4509d18e3cddd03e796dd6fd4fef88070ee5132/7.4/bullseye/apache/Dockerfile) 		|
| [typo3-v10.x](https://github.com/csidirop/typo3-docker/tree/typo3-v10.x) 	| v10.4         	| 7.4         	| Debian 11 Bullseye 	| [php:7.4-apache](https://github.com/docker-library/php/blob/e4509d18e3cddd03e796dd6fd4fef88070ee5132/7.4/bullseye/apache/Dockerfile) 		|
| [typo3-v9.x](https://github.com/csidirop/typo3-docker/tree/typo3-v9.x)  	| v9.5          	| 7.4         	| Debian 11 Bullseye 	| [php:7.4-apache](https://github.com/docker-library/php/blob/e4509d18e3cddd03e796dd6fd4fef88070ee5132/7.4/bullseye/apache/Dockerfile) 		|

### Checkout Branch
    git checkout <branchname>

### Run images:
    docker compose up 

### Set up typo3 with typo3 install tool in your browser:
http://localhost/typo3/install.php
