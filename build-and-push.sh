#!/usr/bin/env bash
set -euo pipefail

# define TYPO3 versions:
majorVersion=13
minorVersion=4

# build and push:
docker compose pull
docker compose build --pull main # `--pull` is redundant since `pull: true` in the compose file
docker compose push main # same as `docker push csidirop/typo3-v13:13.4`
docker tag csidirop/typo3-v${majorVersion}:${majorVersion}.${minorVersion} \
           csidirop/typo3-v${majorVersion}:latest
docker push csidirop/typo3-v${majorVersion}:latest
