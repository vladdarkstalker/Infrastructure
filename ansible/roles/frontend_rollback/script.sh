#!/bin/bash

apk add --no-cache openssh-client
mkdir -p ~/.ssh && chmod 700 ~/.ssh
printf '%s' "$SSH_PRIVATE_KEY_B64_FRONTEND" | base64 -d | tr -d '\r' > ~/.ssh/id_ci
chmod 600 ~/.ssh/id_ci
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ci
ssh-keyscan -p "${DEV_PORT:-22}" -H "$DEV_HOST" >> ~/.ssh/known_hosts
ssh -p "${DEV_PORT:-22}" "${DEV_USER_FRONT}@${DEV_HOST}" <<'REMOTE'
      set -e
      RELEASES=( $(ls -1dt /var/www-data/releases/*/ | head -n 2) )
      if [ "${#RELEASES[@]}" -lt 2 ]; then exit 1; fi
      PREV="${RELEASES[1]}"
      ln -sfn "${PREV}/dist/frontend" "/var/www-data/dist/frontend"
REMOTE
