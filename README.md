# TYPO3 Docker
This repo provides a simple and clean [docker](https://www.docker.com/) image for different [TYPO3](https://typo3.org/) versions.

_All branches are WIP!_

## Docker instructions
### Select branch
There are different [branches](https://github.com/csidirop/typo3-docker/branches) that serve to provide different installations. Those provide following versions:

| **branch** | **TYPO3 version** | **PHP version** | **OS** | **base image** | **last commit** |
|---|---|---|---|---|---|
| main | v11.x | 7.4 | Debian 11 Bullseye | [php:7.4-apache](https://github.com/docker-library/php/blob/e4509d18e3cddd03e796dd6fd4fef88070ee5132/7.4/bullseye/apache/Dockerfile) | [![GitHub last commit (branch)](https://img.shields.io/github/last-commit/csidirop/typo3-docker/main?label=%20)](https://github.com/csidirop/typo3-docker/main/commits/main)  |
| [typo3-v11.x](https://github.com/csidirop/typo3-docker/tree/typo3-v11.x) | v11.5 | 7.4 | Debian 11 Bullseye | [php:7.4-apache](https://github.com/docker-library/php/blob/e4509d18e3cddd03e796dd6fd4fef88070ee5132/7.4/bullseye/apache/Dockerfile) | [![GitHub last commit (branch)](https://img.shields.io/github/last-commit/csidirop/typo3-docker/typo3-v11.x?label=%20)](https://github.com/csidirop/typo3-docker/typo3-v11.x/commits/main) | |
| [typo3-v10.x](https://github.com/csidirop/typo3-docker/tree/typo3-v10.x) | v10.4 | 7.4 | Debian 11 Bullseye | [php:7.4-apache](https://github.com/docker-library/php/blob/e4509d18e3cddd03e796dd6fd4fef88070ee5132/7.4/bullseye/apache/Dockerfile) |  [![GitHub last commit (branch)](https://img.shields.io/github/last-commit/csidirop/typo3-docker/typo3-v10.x?label=%20)](https://github.com/csidirop/typo3-docker/typo3-v10.x/commits/main) |
| [typo3-v9.x](https://github.com/csidirop/typo3-docker/tree/typo3-v9.x) | v9.5 | 7.4 | Debian 11 Bullseye | [php:7.4-apache](https://github.com/docker-library/php/blob/e4509d18e3cddd03e796dd6fd4fef88070ee5132/7.4/bullseye/apache/Dockerfile) |  [![GitHub last commit (branch)](https://img.shields.io/github/last-commit/csidirop/typo3-docker/typo3-v9.x?label=%20)](https://github.com/csidirop/typo3-docker/typo3-v9.x/commits/main) |

<!-- Table created with: https://www.tablesgenerator.com/markdown_tables -->

### Setup
#### Clone this repo
    git clone https://github.com/csidirop/typo3-docker/

#### Checkout Branch
    git checkout <branchname>

#### Run images:
    docker compose up

or

    docker-compose up

#### OR to just build the images:
    docker build -t <anyname> --no-cache .

### Set up TYPO3 with TYPO3 install tool in your browser:
-> http://localhost/typo3/install.php

## Projects using this image

- [kitodo-presentation-docker](https://github.com/UB-Mannheim/kitodo-presentation-docker)
