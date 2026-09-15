# TYPO3 Docker
This repository provides a simple and clean [Docker](https://www.docker.com/) image for different [TYPO3](https://typo3.org/) versions.

_All branches are WIP!_

## Docker instructions
### Select branch
Different [branches](https://github.com/csidirop/typo3-docker/branches) provide the following versions:

| **branch** | **TYPO3 version** | **PHP version** | **OS** | **base image** | **last commit** |
|---|---|---|---|---|---|
| [main](https://github.com/csidirop/typo3-docker/tree/main) | v14.x | 8.4 | Debian 13 Trixie | [php:8.4-apache-trixie](https://hub.docker.com/_/php) | [![GitHub last commit (branch)](https://img.shields.io/github/last-commit/csidirop/typo3-docker/main?label=%20)](https://github.com/csidirop/typo3-docker/commits/main) |
| [typo3-v14.x](https://github.com/csidirop/typo3-docker/tree/typo3-v14.x) | v14.3 | 8.4 | Debian 13 Trixie | [php:8.4-apache-trixie](https://hub.docker.com/_/php) | [![GitHub last commit (branch)](https://img.shields.io/github/last-commit/csidirop/typo3-docker/typo3-v14.x?label=%20)](https://github.com/csidirop/typo3-docker/commits/typo3-v14.x) |
| [typo3-v13.x](https://github.com/csidirop/typo3-docker/tree/typo3-v13.x) | v13.4 | 8.4 | Debian 12 Bookworm | [php:8.4-apache-bookworm](https://hub.docker.com/_/php) | [![GitHub last commit (branch)](https://img.shields.io/github/last-commit/csidirop/typo3-docker/typo3-v13.x?label=%20)](https://github.com/csidirop/typo3-docker/commits/typo3-v13.x) |
| [typo3-v12.x](https://github.com/csidirop/typo3-docker/tree/typo3-v12.x) | v12.4 | 8.4 | Debian 12 Bookworm | [php:8.4-apache-bookworm](https://hub.docker.com/_/php) | [![GitHub last commit (branch)](https://img.shields.io/github/last-commit/csidirop/typo3-docker/typo3-v12.x?label=%20)](https://github.com/csidirop/typo3-docker/commits/typo3-v12.x) |
| [typo3-v11.x](https://github.com/csidirop/typo3-docker/tree/typo3-v11.x) | v11.5 | 8.3 | Debian 12 Bookworm | [php:8.3-apache-bookworm](https://hub.docker.com/_/php) | [![GitHub last commit (branch)](https://img.shields.io/github/last-commit/csidirop/typo3-docker/typo3-v11.x?label=%20)](https://github.com/csidirop/typo3-docker/commits/typo3-v11.x) |
| [typo3-v10.x](https://github.com/csidirop/typo3-docker/tree/typo3-v10.x) | v10.4 | 7.4 | Debian 11 Bullseye | [php:7.4-apache-bullseye](https://hub.docker.com/_/php) | [![GitHub last commit (branch)](https://img.shields.io/github/last-commit/csidirop/typo3-docker/typo3-v10.x?label=%20)](https://github.com/csidirop/typo3-docker/commits/typo3-v10.x) |
| [typo3-v9.x](https://github.com/csidirop/typo3-docker/tree/typo3-v9.x) | v9.5 | 7.4 | Debian 11 Bullseye | [php:7.4-apache-bullseye](https://hub.docker.com/_/php) | [![GitHub last commit (branch)](https://img.shields.io/github/last-commit/csidirop/typo3-docker/typo3-v9.x?label=%20)](https://github.com/csidirop/typo3-docker/commits/typo3-v9.x) |

<!-- Table created with: https://www.tablesgenerator.com/markdown_tables -->

### Setup
#### Clone this repo
    git clone https://github.com/csidirop/typo3-docker/

#### Checkout Branch
    git checkout <branchname>

#### Run containers

    docker compose up

#### OR to just build the images:
    docker build -t <anyname> --no-cache

### Set up TYPO3 with TYPO3 install tool in your browser:
-> http://localhost/

## Projects using this image

- [kitodo-presentation-docker](https://github.com/UB-Mannheim/kitodo-presentation-docker)
