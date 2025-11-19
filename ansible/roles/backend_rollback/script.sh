#!/bin/bash

apk add --no-cache openssh-client
mkdir -p ~/.ssh && chmod 700 ~/.ssh
printf '%s' "$SSH_PRIVATE_KEY_B64_BACKEND" | base64 -d | tr -d '\r' > ~/.ssh/id_ci
chmod 600 ~/.ssh/id_ci
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ci
ssh-keyscan -p "${DEV_PORT:-22}" -H "$DEV_HOST" >> ~/.ssh/known_hosts
ssh -p "${DEV_PORT:-22}" "${DEV_USER_BACK}@${DEV_HOST}" <<'REMOTE'
      set -e
      FILES=( $(ls -1t /opt/sausage-store/bin/sausage-store-*.jar | head -n 2) )
      if [ "${#FILES[@]}" -lt 2 ]; then exit 1; fi
      PREV="${FILES[1]}"
      ln -sfn "${PREV}" /opt/sausage-store/bin/sausage-store.jar
      sudo systemctl restart sausage-backend.service
REMOTE