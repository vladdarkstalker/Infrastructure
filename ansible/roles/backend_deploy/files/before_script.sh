#!/bin/bash

set -euo pipefail
apk add --no-cache openssh-client curl
mkdir -p ~/.ssh
chmod 700 ~/.ssh
printf '%s' "$SSH_PRIVATE_KEY_B64_BACKEND" | base64 -d > ~/.ssh/id_ci
chmod 600 ~/.ssh/id_ci
ssh-keyscan -p "${DEV_PORT:-22}" -H "$DEV_HOST" >> ~/.ssh/known_hosts
